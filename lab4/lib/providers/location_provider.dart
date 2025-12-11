import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationService {
  Future<Position> getPosition() async {
    bool enabled = await Geolocator.isLocationServiceEnabled();
    if (!enabled) {
      throw Exception("Location service is OFF");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      throw Exception("Location permission denied forever");
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }


  Future<String> getCity(double lat, double lon) async {
    final url =
        "https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=$lat&lon=$lon";

    final response = await http.get(
      Uri.parse(url),
      headers: {
        "User-Agent": "Flutter Weather App",
      },
    );

    if (response.statusCode != 200) {
      return "Unknown location";
    }

    final data = jsonDecode(response.body);
    final address = data["address"] ?? {};


    final List<String> priorityFields = [
      "city",
      "town",
      "village",
      "municipality",
      "suburb",
      "hamlet",
      "county",
      "state"
    ];

    for (final field in priorityFields) {
      if (address[field] != null && address[field].toString().trim().isNotEmpty) {
        return address[field];
      }
    }

    return "Unknown location";
  }


  Future<LocationPoint> getLocationFromCity(String city) async {
    final url =
        "https://nominatim.openstreetmap.org/search?q=$city&format=json&limit=1";

    final response = await http.get(
      Uri.parse(url),
      headers: {
        "User-Agent": "Flutter Weather App",
      },
    );

    if (response.statusCode != 200) {
      throw Exception("City not found");
    }

    final data = jsonDecode(response.body);
    if (data.isEmpty) throw Exception("City not found");

    final item = data[0];

    return LocationPoint(
      lat: double.parse(item["lat"]),
      lon: double.parse(item["lon"]),
    );
  }
}


class LocationPoint {
  final double lat;
  final double lon;

  LocationPoint({required this.lat, required this.lon});
}
