import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/weather_cubit.dart';
import '../data/models/weather.dart';

class WeatherSearch extends StatelessWidget {
  const WeatherSearch({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Search '),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          vertical: 16,
        ),
        child: BlocConsumer<WeatherCubit, WeatherState>(
          builder: (context, state) {
            if (state is WeatherInitial) {
              return buildInitialInput();
            } else if (state is WeatherLoading) {
              return buildLoading();
            } else if (state is WeatherLoaded) {
              return buildColumnWithData(state.weather);
            } else {
              return buildInitialInput();
            }
          },
          listener: (context, state) {
            if (state is WeatherError) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
              ));
            }
          },
        ),
      ),
    );
  }
}

Column buildColumnWithData(Weather weather) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Text(
        weather.cityName,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 40,
        ),
      ),
      Text(
        '${weather.temperatureInCelcius.toStringAsFixed(1)} °C',
        style: TextStyle(
          fontSize: 80,
        ),
      ),
      CityInputField(),
    ],
  );
}

Widget buildLoading() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

Widget buildInitialInput() {
  return Center(
    child: CityInputField(),
  );
}

class CityInputField extends StatelessWidget {
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: TextField(
        onSubmitted: (value) => submitCityName(context, value),
        decoration: InputDecoration(
          labelText: 'City Name',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          suffix: Icon(Icons.search),
        ),
      ),
    );
  }

  void submitCityName(BuildContext context, String cityName) {
    final weatherCubit = context.bloc<WeatherCubit>();
    weatherCubit.getWeather(cityName);
  }
}
