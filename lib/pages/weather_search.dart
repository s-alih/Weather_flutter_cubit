import 'package:flutter/material.dart';

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
        child: Container(),
      ),
    );
  }
}
