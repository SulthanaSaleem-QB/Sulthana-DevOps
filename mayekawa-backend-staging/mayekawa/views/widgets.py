from .report_view import WidgetsAPIView


class TemperatureProfile(WidgetsAPIView):
    influx_fields = ['TCI', 'TCO', 'TEI', 'TEO']

    def get_widget_data(self):
        time = set(self.influx_data['TCI']._time.dt.floor(
            '10T').dt.strftime('%H:%M').tolist())
        avarage_temparature = round(((self.te_out + self.tc_out)/2))
        temparatures = [
            self.te_out, self.te_in, avarage_temparature, self.tc_in, self.tc_out
        ]

        avarage_temp_label = round(
            ((self.te_out + self.tc_out)/2)/10)*10
        temparature_labels = [
            self.te_out, self.te_in, avarage_temp_label, self.tc_in, self.tc_out
        ]
        data = {
            "lower_limit": self.te_out - 5,
            "upper_limit": self.tc_out + 5,
            'TCI': self.influx_data['TCI'].TCI.round(2).tolist(),  # .head(10)
            'TCO': self.influx_data['TCO'].TCO.round(2).tolist(),
            'TEI': self.influx_data['TEI'].TEI.round(2).tolist(),
            'TEO': self.influx_data['TEO'].TEO.round(2).tolist(),
            'TCI_time': self.influx_data['TCI']._time.dt.strftime('%H:%M:%S').tolist(),
            'TCO_time': self.influx_data['TCO']._time.dt.strftime('%H:%M:%S').tolist(),
            'TEI_time': self.influx_data['TEI']._time.dt.strftime('%H:%M:%S').tolist(),
            'TEO_time': self.influx_data['TEO']._time.dt.strftime('%H:%M:%S').tolist(),
            'temparature_values': temparatures,
            'temparature_labels': temparature_labels,
            "time_intervals": sorted(time),
        }

        return data
