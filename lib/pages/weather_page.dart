// weather page
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/components/drawer.dart';
import 'package:myapp/models/weather_model.dart';
import 'package:myapp/services/weather_service.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  static String apiKey = ""; // TODO: remember to add your api key

  final WeatherService weatherService = WeatherService(apiKey: apiKey);
  Weather? weather;

  String city = "";
  double tempreture = 0;
  String description = "";
  String lottieName = "cloudy";

  fetchWeather() {
    weatherService.getCityName().then((value) {
      setState(() {
        city = value;
      });
      return value;
    }).then(
      (value) => weatherService.fetchWeather(city).then((value) {
        setState(() {
          tempreture = value.tempreture;
          description = value.description;
          // weather = value;
        });
      }),
    );
  }

 String selectLottie(String condition) {
    switch (condition) {
      default:
        return 'cloudy';
    }

  }
  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  
  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Scaffold(
      appBar: AppBar(),
      drawer: const DrawerComponent(),
      body: Center(
        child: Column(
          children: [
            Text(
              'Weather',
              style: theme.textTheme.h2
            ),
            const SizedBox(height: 20),
            Lottie.asset('assets/lottie/${selectLottie(weather?.description ?? "Loading")}.json'),
            const SizedBox(height: 30),

            Text(
              description,
              style: theme.textTheme.h2
            ),
            Text(
              'City: ${city == "" ? "Lading": city}',
              style: theme.textTheme.p
            ),
            Text(
              'Temperature: $tempreture',
              style: theme.textTheme.p
            ),
          ],
        )
      ),
    );
  }
}