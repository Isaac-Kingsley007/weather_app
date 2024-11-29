import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/weather_service.dart';

void main() {
  runApp(const WeatherApp());
}

String animationName(String main) {
  switch (main) {
    case "Thunderstorm":
      return 'thunder';
    case "Drizzle":
    case "Rain":
      return "shower";
    case "Mist":
    case "Smoke":
    case "Haze":
    case "Dust":
    case "Fog":
    case "Sand":
    case "Ash":
      return "windy";
    case "Clouds":
      return "cloudy";
    default:
      return "sunny";
  }
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Weather App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          canvasColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            color: Colors.black,
          )),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final info = WeatherService();
  Weather weather = Weather(
    temprature: 0,
    city: 'getting city',
    weather: 'clear',
    tempMin: 0,
    tempMax: 0,
    description: '',
  );
  String? assetString;

  void getInformation() async {
    final position = await info.getLocation();
    weather = await info.getWeather(position.latitude, position.longitude);
    assetString = 'assets/${animationName(weather.weather)}.json';
    setState(() {});
    return;
  }

  @override
  void initState() {
    getInformation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: true,
          title: Column(
            children: [
              Text("WEATHER APP",
                  style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ))),
            ],
          ),
          elevation: 0,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Icon(Icons.location_on_outlined, size: 50),
                ),
                Text(weather.city.toUpperCase(),
                    style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ))),
              ],
            ),
            Container(
                height: 256,
                width: 256,
                child: Lottie.asset(assetString ?? 'assets/searching.json')),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Min : ${weather.tempMin.round()}°C',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none)),
                    Text('Max : ${weather.tempMax.round()}°C',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none)),
                  ],
                ),
                Text('${weather.temprature.round()}°C',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 70,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
