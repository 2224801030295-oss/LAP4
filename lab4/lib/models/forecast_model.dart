import 'weather_code_mapper.dart';

class ForecastModel {
  final DateTime dateTime;
  final double tempMin;
  final double tempMax;
  final int weatherCode;

  // 2 field cần cho ForecastScreen
  final String description;
  final String icon;

  ForecastModel({
    required this.dateTime,
    required this.tempMin,
    required this.tempMax,
    required this.weatherCode,
    required this.description,
    required this.icon,
  });

  factory ForecastModel.fromOpenMeteo(
      int timestamp, double min, double max, int code) {
    return ForecastModel(
      dateTime: DateTime.fromMillisecondsSinceEpoch(timestamp * 1000),
      tempMin: min,
      tempMax: max,
      weatherCode: code,
      description: WeatherCodeMapper.description(code),
      icon: WeatherCodeMapper.icon(code),
    );
  }
}
