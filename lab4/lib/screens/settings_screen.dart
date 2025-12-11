import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isCelsius = true;
  bool _is24Hour = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Use Celsius'),
            value: _isCelsius,
            onChanged: (v) => setState(() => _isCelsius = v),
          ),
          SwitchListTile(
            title: const Text('24-hour format'),
            value: _is24Hour,
            onChanged: (v) => setState(() => _is24Hour = v),
          ),
          ListTile(
            title: const Text('Wind unit'),
            subtitle: const Text('m/s, km/h, mph (not implemented)'),
          ),
        ],
      ),
    );
  }
}
