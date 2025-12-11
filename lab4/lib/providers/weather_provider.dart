import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../models/forecast_model.dart';
import '../services/weather_service.dart';
import '../services/location_service.dart';

enum WeatherState { initial, loading, loaded, error }

class WeatherProvider extends ChangeNotifier {
  final WeatherService weatherService;
  final LocationService locationService;

  WeatherProvider(this.weatherService, this.locationService);

  WeatherState state = WeatherState.initial;

  WeatherModel? current;
  List<ForecastModel> forecast = [];
  String? cityName;
  String error = "";

  Future<void> loadByLocation() async {
    state = WeatherState.loading;
    notifyListeners();

    try {
      final pos = await locationService.getPosition();

      cityName = await locationService.getCity(pos.latitude, pos.longitude);

      current = await weatherService.getWeather(pos.latitude, pos.longitude);

      forecast = await weatherService.getForecast(
        pos.latitude,
        pos.longitude,
      );

      state = WeatherState.loaded;
    } catch (e) {
      error = e.toString();
      state = WeatherState.error;
    }

    notifyListeners();
  }

  Future<void> loadByCity(String city) async {
    state = WeatherState.loading;
    notifyListeners();

    try {

      final loc = await locationService.getLocationFromCity(city);

      cityName = city;


      current = await weatherService.getWeather(loc.lat, loc.lon);


      forecast = await weatherService.getForecast(loc.lat, loc.lon);

      state = WeatherState.loaded;
    } catch (e) {
      error = e.toString();
      state = WeatherState.error;
    }

    notifyListeners();
  }
}
