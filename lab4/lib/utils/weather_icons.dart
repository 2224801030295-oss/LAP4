import 'package:flutter/material.dart';

class WeatherIconsUtil {

  static const Map<String, IconData> conditionIcons = {
    'clear': Icons.wb_sunny,
    'clouds': Icons.cloud,
    'rain': Icons.umbrella,
    'drizzle': Icons.cloud_queue,
    'thunderstorm': Icons.flash_on,
    'snow': Icons.ac_unit,
    'mist': Icons.blur_on,
    'fog': Icons.cloud,
    'haze': Icons.blur_circular,
    'smoke': Icons.cloud,
    'dust': Icons.cloud,
    'sand': Icons.cloud,
    'ash': Icons.cloud,
    'squall': Icons.wind_power,
    'tornado': Icons.toys,
  };

  static IconData getIconFromCondition(String condition) {
    final key = condition.toLowerCase();
    if (conditionIcons.containsKey(key)) {
      return conditionIcons[key]!;
    }
    return Icons.help_outline;
  }

  static IconData getIconFromOwmCode(String code) {
    switch (code) {
      case '01d':
        return Icons.wb_sunny;
      case '01n':
        return Icons.nightlight_round;

      case '02d':
      case '02n':
        return Icons.cloud;

      case '03d':
      case '03n':
        return Icons.cloud_queue;

      case '04d':
      case '04n':
        return Icons.cloud;

      case '09d':
      case '09n':
        return Icons.grain;

      case '10d':
      case '10n':
        return Icons.water_drop;

      case '11d':
      case '11n':
        return Icons.flash_on;

      case '13d':
      case '13n':
        return Icons.ac_unit;

      case '50d':
      case '50n':
        return Icons.blur_on;

      default:
        return Icons.help_outline;
    }
  }

  static LinearGradient getBackgroundGradient(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return const LinearGradient(
          colors: [Color(0xFFFFD369), Color(0xFFFFA726)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );

      case 'rain':
      case 'drizzle':
        return const LinearGradient(
          colors: [Color(0xFF6A7FDB), Color(0xFF8EA0F0)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );

      case 'clouds':
        return const LinearGradient(
          colors: [Color(0xFFB0BEC5), Color(0xFFECEFF1)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );

      case 'snow':
        return const LinearGradient(
          colors: [Color(0xFFE0F7FA), Color(0xFFB2EBF2)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );

      case 'thunderstorm':
        return const LinearGradient(
          colors: [Color(0xFF4E5B6E), Color(0xFF2C3A47)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );

      default:
        return const LinearGradient(
          colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
    }
  }

  static Color getTextColorByCondition(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
      case 'snow':
      case 'clouds':
        return Colors.black87;

      default:
        return Colors.white;
    }
  }

  static Color getCardColor(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return Colors.yellow.shade100;

      case 'rain':
      case 'drizzle':
        return Colors.blueGrey.shade300;

      case 'clouds':
        return Colors.grey.shade300;

      default:
        return Colors.blueGrey.shade200;
    }
  }
}
