import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  final String apiKey;
  static const String baseUrl = "https://api.openweathermap.org/data/2.5";

  WeatherService({required this.apiKey});

  String getIconUrl(String iconCode) {
    return "https://openweathermap.org/img/wn/$iconCode@4x.png";
  }

  Future<WeatherModel> getCurrentWeather(String cityName) async {
    final url = Uri.parse(
      "$baseUrl/weather?q=$cityName&appid=$apiKey&units=metric",
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to fetch weather");
    }

    final data = jsonDecode(response.body);
    return WeatherModel.fromJson(data);
  }
}
