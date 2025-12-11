import 'package:flutter/material.dart';

class WeatherDetailItem extends StatelessWidget {
  final String label;
  final String value;
  const WeatherDetailItem({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(value),
      ],
    );
  }
}
