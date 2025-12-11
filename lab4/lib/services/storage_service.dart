class WeatherModel {
  final String cityName;
  final double temperature;
  final String description;
  final String icon;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.icon,
  });

  factory WeatherModel.fromOpenMeteo(
      Map<String, dynamic> json, double lat, double lon) {
    final current = json["current_weather"];
    int code = current["weathercode"];

    return WeatherModel(
      cityName: "Your Location",
      temperature: (current["temperature"] ?? 0).toDouble(),
      description: WeatherCodeMapper.description(code),
      icon: WeatherCodeMapper.icon(code),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "cityName": cityName,
      "temperature": temperature,
      "description": description,
      "icon": icon,
    };
  }

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json["cityName"] ?? "Unknown",
      temperature: (json["temperature"] ?? 0).toDouble(),
      description: json["description"] ?? "",
      icon: json["icon"] ?? "",
    );
  }
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
      default:
        return "Unknown";
    }
  }

  static String icon(int code) {
    if (code == 0) return "01d";
    if ([1, 2, 3].contains(code)) return "02d";
    if ([61, 63, 65].contains(code)) return "09d";
    return "50d";
  }
}
