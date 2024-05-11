from rest_framework import serializers


class ReportInputsSerializer(serializers.Serializer):
    start_time = serializers.CharField()
    stop_time = serializers.CharField()
    product_code = serializers.CharField()
    refrigerant_charge = serializers.CharField()
    project_name = serializers.CharField()
    customer_name = serializers.CharField()
    test_condition = serializers.CharField()
    tc_in = serializers.CharField()
    tc_out = serializers.CharField()
    te_in = serializers.CharField()
    te_out = serializers.CharField()