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
      case 80:
      case 81:
      case 82:
        return "Rain";
      case 71:
      case 73:
      case 75:
        return "Snow";
      default:
        return "Unknown";
    }
  }

  static String icon(int code) {
    if (code == 0) return "01d";
    if ([1, 2, 3].contains(code)) return "02d";
    if ([45, 48].contains(code)) return "50d";
    if ([51, 53, 55].contains(code)) return "09d";
    if ([61, 63, 65, 80, 81, 82].contains(code)) return "10d";
    if ([71, 73, 75].contains(code)) return "13d";
    return "03d";
  }
}
