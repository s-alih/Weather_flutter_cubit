import 'dart:math';
import './models/weather.dart';

abstract class WeatherRepository {
  ///Throws [NetworkException].
  Future<Weather> fetchWeather(String cityName);
}

class FakeRepository implements WeatherRepository {
  @override
  Future<Weather> fetchWeather(String cityName) {
    //simulate Network delay
    return Future.delayed(
      Duration(
        seconds: 1,
      ),
      () {
        final random = Random();
        //simulate some network exception
        if (random.nextBool()) {
          throw NetworkException();
        }
        //return fetched weather
        return Weather(
          cityName: cityName,
          temperatureInCelcius: 20 + random.nextInt(15) + random.nextDouble(),
        );
      },
    );
  }
}

class NetworkException implements Exception {}
