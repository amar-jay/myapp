class Weather {
  String city;
  double tempreture;
  String description; // weather condition

  Weather({
    required this.city,
    required this.tempreture,
    required this.description,
  });

  // json parse
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      city: json['name'],
      tempreture: json['main']['temp'],
      description: json['weather'][0]['main'],
    );
  }

}

Weather newWeather(String city) {
  return Weather(city: "", tempreture: 0, description: '');
}