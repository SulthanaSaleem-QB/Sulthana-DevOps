from rest_framework import generics
from rest_framework.permissions import IsAuthenticated
# from rest_framework.authentication import SessionAuthentication, BasicAuthentication
from rest_framework import status
from rest_framework.response import Response
from mayekawa.serializers import ReportInputsSerializer
from django.core.cache import cache
from django.conf import settings
from datetime import datetime
import logging

from influxdb_client import InfluxDBClient
import warnings
from influxdb_client.client.warnings import MissingPivotFunction
warnings.simplefilter("ignore", MissingPivotFunction)


class WidgetsAPIView(generics.GenericAPIView):
    permission_classes = (IsAuthenticated,)
    serializer_class = ReportInputsSerializer
    start_time = None
    stop_time = None
    product_code = None
    refrigerant_charge = None
    project_name = None
    customer_name = None
    test_condition = None
    tc_in = None  # Temparature condednser inlet
    tc_out = None  # Temparature condednser outlet
    te_in = None  # Temparature Evaporator inlet
    te_out = None  # Temparature Evaporator outlet
    window_period = "10s"
    influx_fields = []
    influx_data = {}
    influx_client = InfluxDBClient(
        url=settings.INFLUX_DB_URL,
        token=settings.INFLUX_DB_TOKEN,
        org=settings.INFLUX_DB_ORG, debug=False
    )

    def format_datetime(self, date_time_value):
        date_time_value = date_time_value.strip('"')
        date_time_value = datetime.strptime(
            date_time_value, '%Y-%m-%dT%H:%M:%SZ')
        date_time_value = date_time_value.strftime('%Y-%m-%dT%H:%M:%SZ')

        return date_time_value

    def set_values_from_input(self, request):
        start_time_str = request.data.get('start_time', None)
        self.start_time = self.format_datetime(start_time_str)

        stop_time_str = request.data.get('stop_time', None)
        self.stop_time = self.format_datetime(stop_time_str)

        self.product_code = request.data.get('product_code', None)
        self.refrigerant_charge = request.data.get('refrigerant_charge', None)
        self.project_name = request.data.get('project_name', None)
        self.customer_name = request.data.get('customer_name', None)
        self.test_condition = request.data.get('test_condition', None)

        if self.test_condition == "NTC1":
            self.tc_in = 30
            self.tc_out = 35
            self.te_in = 12
            self.te_out = 7
        else:
            self.tc_in = request.data.get('tc_in', None)
            self.tc_out = request.data.get('tc_out', None)
            self.te_in = request.data.get('te_in', None)
            self.te_out = request.data.get('te_out', None)

            if not self.tc_in or not self.tc_out or not self.te_in or not self.te_out:
                return Response(
                    {"message": "Please fill all custom values"},
                    status=status.HTTP_400_BAD_REQUEST
                )

    def get_cache_key(self, field):
        return f'influx_data_{self.start_time}_{self.stop_time}_{field}'

    def set_influx_data(self):
        for field in self.influx_fields:
            cache_key = self.get_cache_key(field)
            cached_data = cache.get(cache_key)

            if cached_data is not None:
                self.influx_data[field] = cached_data
            else:
                self.influx_data[field] = self.get_influx_data(field)
                cache.set(cache_key, self.influx_data[field], 24*60*60)

    # Helper function to generate influx query and return data
    def get_influx_data(self, field):
        if not self.start_time or not self.stop_time or self.start_time == self.stop_time:
            return Response(
                {"message": "Please valied start and Stop time"},
                status=status.HTTP_400_BAD_REQUEST
            )

        print("Collecting: \"{}\"".format(field))
        # TODO add product code checking in future if needed
        query = '\
        from(bucket: "FAT")\
          |> range(start:' + self.start_time + ', stop:' + self.stop_time + ')\
          |> filter(fn: (r) => r["_measurement"] == "FAT")\
          |> filter(fn: (r) => r["_field"] == "' + field + '")\
          |> filter(fn: (r) => r["device"] == "' + settings.DEVICE_CHILLER + '")\
          |> aggregateWindow(every: ' + self.window_period + ', fn: max, createEmpty: false)\
          |> yield(name: "mean")\
        '
        data = self.influx_client.query_api().query_data_frame(
            org=settings.INFLUX_DB_ORG, query=query
        )
        data.set_index("_time")
        data.drop(columns=['result', 'table', '_start', '_stop',
                  'model', 'type', 'location', '_measurement'])
        data.rename(columns={'_value': '{}'.format(field)}, inplace=True)

        return data

    def get_widget_data(self):
        return {}

    def post(self, request):
        try:
            self.set_values_from_input(request)
            self.set_influx_data()
            data = self.get_widget_data()
            return Response(
                {
                    "message": "Successfuly retrived widget data",
                    "status": status.HTTP_200_OK,
                    "data": data
                },
                status=status.HTTP_200_OK
            )
        except Exception as e:
            print(e)
            logging.info(f'Error in wigeds API view: {e}')
            return Response(
                {
                    "message": f"Error: {e}",
                    'status': status.HTTP_500_INTERNAL_SERVER_ERROR
                },
                status=status.HTTP_200_OK
            )
