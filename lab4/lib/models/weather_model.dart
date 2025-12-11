import 'dart:convert';

class WeatherModel {
  final String cityName;
  final String country;
  final double temperature;
  final double feelsLike;
  final double? tempMin;
  final double? tempMax;
  final int? humidity;
  final double? windSpeed;
  final int? pressure;
  final int? visibility;
  final int? cloudiness;
  final String description;
  final String mainCondition;
  final String icon; // trả về mã icon kiểu OWM, ví dụ "01d"
  final DateTime dateTime;

  WeatherModel({
    required this.cityName,
    required this.country,
    required this.temperature,
    required this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.humidity,
    this.windSpeed,
    this.pressure,
    this.visibility,
    this.cloudiness,
    required this.description,
    required this.mainCondition,
    required this.icon,
    required this.dateTime,
  });

  factory WeatherModel.fromOpenMeteo(
      Map<String, dynamic> json, double lat, double lon) {
    // current weather object
    final current = json['current_weather'] ?? {};
    // hourly & daily may exist
    final hourly = json['hourly'] ?? {};
    final daily = json['daily'] ?? {};
    int? humidity;
    try {
      if (hourly['relativehumidity_2m'] != null &&
          hourly['relativehumidity_2m'] is List &&
          (hourly['relativehumidity_2m'] as List).isNotEmpty) {
        humidity = (hourly['relativehumidity_2m'][0] as num).toInt();
      }
    } catch (_) {
      humidity = null;
    }

    double? tempMin;
    double? tempMax;
    try {
      if (daily['temperature_2m_min'] != null &&
          (daily['temperature_2m_min'] as List).isNotEmpty) {
        tempMin = (daily['temperature_2m_min'][0] as num).toDouble();
      }
      if (daily['temperature_2m_max'] != null &&
          (daily['temperature_2m_max'] as List).isNotEmpty) {
        tempMax = (daily['temperature_2m_max'][0] as num).toDouble();
      }
    } catch (_) {
      tempMin = null;
      tempMax = null;
    }

    int weatherCode = 0;
    try {
      weatherCode = (current['weathercode'] ?? 0) as int;
    } catch (_) {
      weatherCode = 0;
    }

    final description = WeatherCodeMapper.description(weatherCode);
    final main = WeatherCodeMapper.main(weatherCode);
    final icon = WeatherCodeMapper.icon(weatherCode);

    // build model — fill missing fields with reasonable defaults
    return WeatherModel(
      cityName: "Your Location", // nếu muốn tên thật, dùng reverse-geocoding
      country: "",
      temperature: (current['temperature'] ?? 0).toDouble(),
      feelsLike: (current['temperature'] ?? 0).toDouble(),
      tempMin: tempMin,
      tempMax: tempMax,
      humidity: humidity,
      windSpeed: (current['windspeed'] ?? 0).toDouble(),
      pressure: null,
      visibility: null,
      cloudiness: null,
      description: description,
      mainCondition: main,
      icon: icon,
      dateTime: DateTime.tryParse(current['time'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cityName': cityName,
      'country': country,
      'temperature': temperature,
      'feelsLike': feelsLike,
      'tempMin': tempMin,
      'tempMax': tempMax,
      'humidity': humidity,
      'windSpeed': windSpeed,
      'pressure': pressure,
      'visibility': visibility,
      'cloudiness': cloudiness,
      'description': description,
      'mainCondition': mainCondition,
      'icon': icon,
      'dateTime': dateTime.millisecondsSinceEpoch ~/ 1000,
    };
  }

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['cityName'] ?? 'Unknown',
      country: json['country'] ?? '',
      temperature: (json['temperature'] ?? 0).toDouble(),
      feelsLike: (json['feelsLike'] ?? 0).toDouble(),
      tempMin: json['tempMin'] != null ? (json['tempMin'] as num).toDouble() : null,
      tempMax: json['tempMax'] != null ? (json['tempMax'] as num).toDouble() : null,
      humidity: json['humidity'] != null ? (json['humidity'] as num).toInt() : null,
      windSpeed: json['windSpeed'] != null ? (json['windSpeed'] as num).toDouble() : null,
      pressure: json['pressure'] != null ? (json['pressure'] as num).toInt() : null,
      visibility: json['visibility'] != null ? (json['visibility'] as num).toInt() : null,
      cloudiness: json['cloudiness'] != null ? (json['cloudiness'] as num).toInt() : null,
      description: json['description'] ?? '',
      mainCondition: json['mainCondition'] ?? '',
      icon: json['icon'] ?? '',
      dateTime: DateTime.fromMillisecondsSinceEpoch(
        ((json['dateTime'] ?? json['dt']) as int? ?? DateTime.now().millisecondsSinceEpoch) * 1000,
      ),
    );
  }

  String get iconUrl => "https://openweathermap.org/img/wn/$icon@4x.png";

  String get temperatureString => "${temperature.round()}°";

  @override
  String toString() => jsonEncode(toJson());
}

class WeatherCodeMapper {
  static String description(int code) {
    switch (code) {
      case 0:
        return "Clear sky";
      case 1:
      case 2:
      case 3:
        return "Partly cloudy";
      case 45:
      case 48:
        return "Fog";
      case 51:
      case 53:
      case 55:
        return "Drizzle";
      case 61:
      case 63:
      case 65:
        return "Rain";
      case 71:
      case 73:
      case 75:
        return "Snow";
      case 80:
      case 81:
      case 82:
        return "Rain showers";
      default:
        return "Unknown";
    }
  }

  static String main(int code) {
    if (code == 0) return "Clear";
    if ([1, 2, 3].contains(code)) return "Clouds";
    if ([45, 48].contains(code)) return "Fog";
    if ([51, 53, 55].contains(code)) return "Drizzle";
    if ([61, 63, 65, 80, 81, 82].contains(code)) return "Rain";
    if ([71, 73, 75].contains(code)) return "Snow";
    return "Other";
  }

  static String icon(int code) {
    // trả về mã icon kiểu OpenWeather (ví dụ "10d", "01d")
    if (code == 0) return "01d";
    if ([1, 2, 3].contains(code)) return "02d";
    if ([45, 48].contains(code)) return "50d";
    if ([51, 53, 55].contains(code)) return "09d";
    if ([61, 63, 65, 80, 81, 82].contains(code)) return "10d";
    if ([71, 73, 75].contains(code)) return "13d";
    return "03d";
  }
}
