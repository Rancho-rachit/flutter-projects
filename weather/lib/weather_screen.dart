import 'dart:convert';
import 'dart:ui';
// import 'package:again_weather/API.dart';
import 'package:again_weather/additional_info.dart';
import 'package:again_weather/hourly_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<Map<String, dynamic>> weather;
  @override
  void initState() {
    super.initState();
    weather = getCurrentWeather();
    print(weather);
  }

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      final api = dotenv.env['WEATHER_API'];
      final res = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?lat=22.788502&lon=75.89051&APPID=$api'),
      );
      final data = jsonDecode(res.body);
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
                onPressed: () {
                  setState(() {
                    weather = getCurrentWeather();
                  });
                },
                icon: const Icon(Icons.refresh)),
          )
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          final data = snapshot.data!;

          final currentWeatherData = data['list'][0];

          final currentTemp =
              (currentWeatherData['main']['temp'] - 273).toStringAsFixed(1);
          final currentSky = currentWeatherData['weather'][0]['main'];
          final currentPressure = currentWeatherData['main']['pressure'];
          final currentWindSpeed = currentWeatherData['wind']['speed'];
          final currentHumidity = currentWeatherData['main']['humidity'];

          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                // main card
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                '$currentTemp°C',
                                style: TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Icon(
                                currentSky == 'Clouds' || currentSky == 'Rain'
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 64,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                currentSky,
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Hourly Forecast',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),

                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    itemCount: 6,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final hourlyForecast = data['list'][index + 1];
                      final hourlySky =
                          data['list'][index + 1]['weather'][0]['main'];
                      final hourlyTemp = (hourlyForecast['main']['temp'] - 273)
                          .toStringAsFixed(2);
                      final time = DateTime.parse(hourlyForecast['dt_txt']);
                      return Cardio(
                        time: DateFormat.j().format(time),
                        value: '$hourlyTemp°C',
                        icon: hourlySky == 'Clouds' || hourlySky == 'Rain'
                            ? Icons.cloud
                            : Icons.sunny,
                      );
                    },
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                //additional info

                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Additional Information',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    )),

                SizedBox(
                  height: 8,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AdditionalInfo(
                        icon: Icons.water_drop,
                        label: 'Humidity',
                        value: currentHumidity.toString()),
                    AdditionalInfo(
                        icon: Icons.air,
                        label: 'Wind Speed',
                        value: currentWindSpeed.toString()),
                    AdditionalInfo(
                        icon: Icons.beach_access,
                        label: 'Pressure',
                        value: currentPressure.toString())
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
