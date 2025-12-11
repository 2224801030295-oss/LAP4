import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WeatherProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // ================================
            // 🔍 Ô nhập tên thành phố
            // ================================
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: cityController,
                    decoration: const InputDecoration(
                      hintText: "Nhập tên thành phố...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                ElevatedButton(
                  onPressed: () {
                    if (cityController.text.trim().isNotEmpty) {
                      provider.loadByCity(cityController.text.trim());
                    }
                  },
                  child: const Icon(Icons.search),
                )
              ],
            ),

            const SizedBox(height: 25),

            Expanded(
              child: switch (provider.state) {

                WeatherState.loading =>
                const Center(child: CircularProgressIndicator()),

                WeatherState.error =>
                    Center(child: Text(provider.error,
                        style: const TextStyle(color: Colors.red))),

                WeatherState.loaded =>
                    _buildWeatherUI(provider),

                _ => const Center(
                    child: Text("Nhập thành phố hoặc dùng nút GPS")),
              },
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => provider.loadByLocation(),
        child: const Icon(Icons.location_on),
      ),
    );
  }

  // ================================
  // UI hiển thị thời tiết
  // ================================
  Widget _buildWeatherUI(WeatherProvider provider) {
    final weather = provider.current!;
    final city = provider.cityName ?? "Unknown";

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          city,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 10),

        // ICON thời tiết
        Image.network(
          "https://openweathermap.org/img/wn/${weather.icon}@4x.png",
          width: 120,
          height: 120,
        ),

        Text(
          "${weather.temperature}°C",
          style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
        ),

        Text(
          weather.description,
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
