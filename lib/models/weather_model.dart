class Weather {
  final String city;
  final double temperature;
  final String description; // weather condition

  Weather({
    required this.city,
    required this.temperature,
    required this.description,
  });

  // json parse
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      city: json['name'],
      temperature: json['main']['temp'],
      description: json['weather'][0]['main'],
    );
  }

}