import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const WeatherHomePage(),
      theme: ThemeData(primarySwatch: Colors.blueGrey),
    );
  }
}

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});
  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  String _status = 'Checking connection...';
  Map<String, dynamic>? _weather;

  @override
  void initState() {
    super.initState();
    _checkAndFetch();
  }

  Future<void> _checkAndFetch() async {
    final conn = await Connectivity().checkConnectivity();
    if (conn != ConnectivityResult.wifi) {
      setState(() => _status = 'Not on Wi-Fi');
      return;
    }

    try {
      final res = await http.get(Uri.parse('http://10.1.0.1/data.json')).timeout(const Duration(seconds: 5));
      final data = json.decode(res.body);
      if (data is Map<String, dynamic>) {
        setState(() => _weather = data);
      } else {
        setState(() => _status = 'Invalid data format');
      }
    } catch (e) {
      setState(() => _status = 'Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ESP32 Weather')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: _weather == null
            ? Text(_status, style: const TextStyle(fontSize: 20))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Temp: ${_weather!['temperature']}°C', style: const TextStyle(fontSize: 20)),
                  Text('Humidity: ${_weather!['humidity']}%', style: const TextStyle(fontSize: 20)),
                  Text('Pressure: ${_weather!['pressure']} hPa', style: const TextStyle(fontSize: 20)),
                ],
              ),
      ),
    );
  }
}
