import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';
import '../models/forecast_model.dart';
import '../config/api_config.dart';

class WeatherService {
  Future<WeatherModel> getWeather(double lat, double lon) async {
    final url = ApiConfig.buildUrl(lat, lon);
    final res = await http.get(Uri.parse(url));

    if (res.statusCode != 200) throw Exception("Weather failed");

    return WeatherModel.fromOpenMeteo(jsonDecode(res.body), lat, lon);
  }

  Future<List<ForecastModel>> getForecast(double lat, double lon) async {
    final url =
        "${ApiConfig.baseUrl}?latitude=$lat&longitude=$lon&daily=weathercode,temperature_2m_min,temperature_2m_max&timezone=auto";

    final res = await http.get(Uri.parse(url));
    if (res.statusCode != 200) throw Exception("Forecast failed");

    final data = jsonDecode(res.body);

    final dates = data["daily"]["time"];
    final min = data["daily"]["temperature_2m_min"];
    final max = data["daily"]["temperature_2m_max"];
    final codes = data["daily"]["weathercode"];

    List<ForecastModel> list = [];

    for (int i = 0; i < dates.length; i++) {
      list.add(
        ForecastModel.fromOpenMeteo(
          DateTime.parse(dates[i]).millisecondsSinceEpoch ~/ 1000,
          min[i].toDouble(),
          max[i].toDouble(),
          codes[i],
        ),
      );
    }

    return list;
  }
}
