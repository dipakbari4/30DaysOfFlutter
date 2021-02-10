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
  String _changedName = "someText";

  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _changedName = "";
    super.initState();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _headSection = Container(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Text(
            "Name Changer",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
        ]),
        Row(children: [
          Text(
            "This will change the given name",
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
          )
        ]),
      ],
    ),
  );

  Widget _nameSection() {
    return Container(
      padding: EdgeInsets.all(16),
      child: TextFormField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: 'Enter you full name here',
          labelText: 'Full Name',
        ),
      ),
    );
  }

  String replaceCharAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index) +
        newChar +
        oldString.substring(index + 1);
  }

  Widget _buttonSection() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            child: Text("Change"),
            onPressed: () {
              setState(() {
                var txt = _controller.text;

                if (txt.split(" ").length >= 2) {
                  var firstName = txt.split(" ")[0];
                  var lastName = txt.split(" ")[1];

                  txt = replaceCharAt(firstName, 0, lastName[0]) +
                      ' ' +
                      replaceCharAt(lastName, 0, firstName[0]);
                  _changedName = txt;
                } else {
                  _changedName = "Please enter your full name";
                }
              });
            },
          ),
        ],
      ),
    );
  }

  var _changedNameSection = (String changedName) => Container(
        child: Text(
          '$changedName',
          style: TextStyle(fontSize: 20),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Name Changer | Day 6 of #30DaysOfFlutter"),
      ),
      body: Column(
        children: [
          _headSection,
          _nameSection(),
          _buttonSection(),
          _changedNameSection('$_changedName'),
        ],
      ),
    );
  }
}
