import 'dart:math';

import 'package:flutter/material.dart';
import 'constants/helper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _mainText;

  var _textStyle = TextStyle(
    fontSize: 20,
    color: Color.fromRGBO(
      Random().nextInt(256),
      Random().nextInt(256),
      Random().nextInt(256),
      1,
    ),
  );

  @override
  void initState() {
    _mainText = "Press the Floating action button to start";
    super.initState();
  }

  double getRandomFromRange(int min, int max) {
    return min + Random().nextInt(max - min).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Day 1 of #30DaysOfFlutter | Flutter Family"),
      ),
      body: Center(
        child: Text(
          _mainText,
          style: _textStyle,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _textStyle = TextStyle(
              fontSize: getRandomFromRange(18, 36),
              color: Color.fromRGBO(
                Random().nextInt(255),
                Random().nextInt(255),
                Random().nextInt(255),
                1,
              ),
            );
            _mainText = People
                .contributors[Random().nextInt(People.contributors.length)];
          });
        },
        child: const Icon(
          Icons.autorenew,
        ),
      ),
    );
  }
}
