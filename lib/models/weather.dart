class Weather {
  final double temprature;
  final double tempMin;
  final double tempMax;
  final String city;
  final String weather;
  final String description;

  Weather(
      {required this.temprature, required this.city, required this.weather, required this.tempMin, required this.tempMax, required this.description,});

  factory Weather.fromJson(json) {
    return Weather(
      weather: json["weather"][0]["main"],
      city: json["name"],
      temprature: json["main"]["temp"].toDouble(),
      tempMin: json["main"]["temp_min"].toDouble(),
      tempMax: json["main"]["temp_max"].toDouble(),
      description: json["weather"][0]["description"],
    );
  }
}
