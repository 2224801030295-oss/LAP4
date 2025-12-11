import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/weather_service.dart';
import 'services/location_service.dart';
import 'providers/weather_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => WeatherService()),
        Provider(create: (_) => LocationService()),
        ChangeNotifierProxyProvider2<WeatherService, LocationService,
            WeatherProvider>(
          create: (_) => WeatherProvider(WeatherService(), LocationService()),
          update: (_, weather, location, __) =>
              WeatherProvider(weather, location),
        ),
      ],
      child: MaterialApp(
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
