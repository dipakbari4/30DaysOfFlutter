import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _items = List<String>.generate(30, (index) => "Item ${index + 1}");
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Dismissible | Day 4 of #30DaysOfFlutter"),
      ),
      body: ListView.builder(
          itemCount: _items.length,
          itemBuilder: (ctx, pos) {
            final _item = _items[pos];
            return Dismissible(
              key: Key(_item),
              onDismissed: (direction) {
                setState(() {
                  _items.removeAt(pos);
                });
                _scaffoldKey.currentState.showSnackBar(
                  SnackBar(
                    content: Text("$_item dismissed"),
                    duration: Duration(milliseconds: 700),
                  ),
                );
              },
              background: Container(
                color: Colors.red[100],
              ),
              child: ListTile(title: Text(_item)),
            );
          }),
    );
  }
}
