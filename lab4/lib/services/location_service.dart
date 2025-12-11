import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CityLocation {
  final double lat;
  final double lon;

  CityLocation(this.lat, this.lon);
}

class LocationService {
  Future<Position> getPosition() async {
    bool enabled = await Geolocator.isLocationServiceEnabled();
    if (!enabled) throw Exception("Location disabled");

    LocationPermission perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) {
      perm = await Geolocator.requestPermission();
    }
    if (perm == LocationPermission.deniedForever) {
      throw Exception("Location permanently denied");
    }

    return Geolocator.getCurrentPosition();
  }

  Future<String> getCity(double lat, double lon) async {
    final url =
        "https://nominatim.openstreetmap.org/reverse?lat=$lat&lon=$lon&format=json";

    final res = await http.get(Uri.parse(url), headers: {
      "User-Agent": "WeatherApp"
    });

    if (res.statusCode != 200) return "Unknown";

    final data = jsonDecode(res.body);

    return data["address"]?["city"] ??
        data["address"]?["town"] ??
        data["address"]?["village"] ??
        data["address"]?["county"] ??
        "Unknown";
  }

  Future<CityLocation> getLocationFromCity(String city) async {
    final url =
        "https://nominatim.openstreetmap.org/search?q=$city&format=json&limit=1";

    final res = await http.get(Uri.parse(url), headers: {
      "User-Agent": "WeatherApp"
    });

    final data = jsonDecode(res.body);
    if (data.isEmpty) throw Exception("City not found");

    return CityLocation(
      double.parse(data[0]["lat"]),
      double.parse(data[0]["lon"]),
    );
  }
}
