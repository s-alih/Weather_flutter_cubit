part of 'weather_bloc.dart';

abstract class WeatherEvent {}

class GetWeather extends WeatherEvent {
  final String cityName;
  GetWeather(this.cityName);
}
