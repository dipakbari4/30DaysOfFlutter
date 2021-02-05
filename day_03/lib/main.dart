import 'package:flutter/material.dart';
import 'constants/helper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'LayoutSwitch | Day 3 of #30DaysOfFlutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List _members = People.members;
  Set _saved = Set<String>();
  bool _isListView;
  TextEditingController _controller = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  initState() {
    _members.shuffle();
    _isListView = true;
    super.initState();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget switchedLayout() {
    if (_isListView) {
      return ListView.builder(
          itemCount: _members.length,
          itemBuilder: (ctx, pos) {
            return buildListItem(
                _members[pos], " ${_members[pos].split(" ")[0]} 💙 Flutter");
          });
    } else {
      return GridView.builder(
          itemCount: _members.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (ctx, pos) {
            return buildGridItem(
                _members[pos], "${_members[pos].split(" ")[0]} 💙 Flutter");
          });
    }
  }

  Widget buildListItem(String title, String subtitle) {
    final alreadySaved = _saved.contains(title);

    void updateUI() {
      setState(() {
        if (_saved.contains(title)) {
          _saved.remove(title);
        } else {
          _saved.add(title);
        }
      });
    }

    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: () {
        updateUI();
      },
      trailing: IconButton(
        icon: Icon(
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: Colors.blue,
        ),
        onPressed: () {
          updateUI();
        },
      ),
    );
  }

  Widget buildGridItem(String title, String subtitle) {
    final alreadySaved = _saved.contains(title);

    void updateUI() {
      setState(() {
        if (_saved.contains(title)) {
          _saved.remove(title);
        } else {
          _saved.add(title);
        }
      });
    }

    return Card(
      child: InkWell(
        onTap: () {
          updateUI();
        },
        child: Column(
          children: [
            SizedBox(
              height: 18,
            ),
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Text(subtitle),
            SizedBox(
              height: 20,
            ),
            Center(
              child: IconButton(
                iconSize: 50,
                icon: Icon(
                  alreadySaved ? Icons.favorite : Icons.favorite_border,
                  color: Colors.blue,
                ),
                onPressed: () {
                  updateUI();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(_isListView ? Icons.grid_view : Icons.list),
            onPressed: () {
              setState(() {
                _isListView = !_isListView;
              });
            },
          ),
        ],
      ),
      body: switchedLayout(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text("Add new Flutter member"),
              content: TextFormField(
                autocorrect: false,
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Full name",
                  labelText: "Enter new Flutter member",
                ),
              ),
              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("DISMISS"),
                ),
                FlatButton(
                    onPressed: () {
                      if (_controller.text.length == 0) {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text(
                                "Please enter new member name then try again!")));
                        Navigator.of(context).pop();
                      } else {
                        setState(() {
                          _members.add(_controller.text);
                          _controller.clear();
                        });
                        _scaffoldKey.currentState.showSnackBar(
                            SnackBar(content: Text("New member added!")));
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text("ADD")),
              ],
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
