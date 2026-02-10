import 'package:flutter/material.dart';
import 'package:weather/constant.dart';
import 'package:weather/domain/openweather.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Add MaterialApp here
      home: WatherApp(),
    );
  }
}

class WatherApp extends StatefulWidget {
  final Openweather openweather;

  WatherApp({super.key})
    : openweather = const Openweather(apiKey: api); // Initialize here

  @override
  State<WatherApp> createState() => _WatherAppState();
}

class _WatherAppState extends State<WatherApp> {
  @override
  void initState() {
    super.initState(); // Call super.initState() first
    // var res = widget.openweather.getWeatherDetails(lat: 37.330, lon: -122.4912);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather App')),
      body: SafeArea(
        child: Center(
          child: FutureBuilder(
            future: widget.openweather.getWeatherDetails(
              lat: 6.9271,
              lon: 79.8612,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              var data = snapshot.data;
              return Column(
                children: [
                  Image.network(
                    widget.openweather.getWeatherIcon(
                      data!['weather'][0]['icon'],
                    ),
                    width: 100,
                    height: 100,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: data['main']['temp'].toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: '°C',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  Text(data['name'].toString()),
                  Text(data['sys']['country'].toString()),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
