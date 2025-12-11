class ApiConfig {
  static const String baseUrl = 'https://api.open-meteo.com/v1/forecast';

  static String buildUrl(double lat, double lon) {
    return '$baseUrl'
        '?latitude=$lat'
        '&longitude=$lon'
        '&current_weather=true'
        '&hourly=temperature_2m,relativehumidity_2m,windspeed_10m'
        '&daily=weathercode,temperature_2m_max,temperature_2m_min'
        '&timezone=auto';
  }
}
