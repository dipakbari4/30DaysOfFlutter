import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _items = List<String>.generate(50, (index) => "Color ${index + 1}");
  var _colors = List<Color>();

  @override
  void initState() {
    _colors = List<Color>.generate(50, (index) => Colors.blue);
    super.initState();
  }

  void generateColors() {
    setState(() {
      _colors = List<Color>.generate(
          50,
          (index) => Color.fromARGB(
              Random().nextInt(255),
              Random().nextInt(255),
              Random().nextInt(255),
              Random().nextInt(255)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Color Gen | Day 7 of #30DaysOfFlutter"),
      ),
      body: ListView.builder(
          itemCount: _items.length,
          itemBuilder: (ctx, pos) {
            return ListTile(
              leading: Container(
                color: _colors[pos],
                child: const SizedBox(
                  width: 50,
                  height: 50,
                ),
              ),
              title: Text(_items[pos]),
              subtitle: Text("#${_colors[pos].value.toRadixString(16)}"),
              onTap: () {},
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.brush),
        onPressed: () {
          generateColors();
        },
      ),
    );
  }
}
