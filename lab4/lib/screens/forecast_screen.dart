import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../utils/date_formatter.dart';
import '../utils/weather_icons.dart';

class ForecastScreen extends StatelessWidget {
  const ForecastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WeatherProvider>();
    final forecast = provider.forecast;

    return Scaffold(
      appBar: AppBar(
        title: const Text("5-Day Forecast"),
        centerTitle: true,
      ),
      body: provider.state == WeatherState.loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: forecast.length,
        itemBuilder: (context, index) {
          final item = forecast[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: ListTile(
              leading: Icon(WeatherIconsUtil.getIconFromOwmCode(item.icon), size: 40),
              title: Text(DateFormatter.formatDate(item.dateTime)),
              subtitle: Text(item.description),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Min: ${item.tempMin}°C"),
                  Text("Max: ${item.tempMax}°C"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
