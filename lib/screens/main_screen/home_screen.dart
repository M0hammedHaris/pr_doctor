import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:pr_doctor/screens/botscreen/bot.dart';
import 'package:pr_doctor/screens/ingredent_screen/ingredient.dart';
import 'package:pr_doctor/screens/login/login_page.dart';
import 'package:pr_doctor/screens/map_screen/map.dart';
import 'package:provider/provider.dart';
import 'package:pr_doctor/database/database.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:toast/toast.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  getNameFromDb() async {
    final database = Provider.of<AppDatabase>(context, listen: false);
    final data = await database.getAllData();

    setState(() {
      name = data.userName;
    });
  }

  @override
  void initState() {
    super.initState();
    getNameFromDb();
    _checkConnection();
  }

  Widget _drawer() {
    return Drawer(
      elevation: 20,
      child: ListView(
        children: <Widget>[
          DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: <Color>[Colors.cyan, Colors.cyan[100]]),
              ),
              child: null),
          ListTile(
              leading: Icon(Icons.map, color: Colors.black),
              title: Text('Find stores'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MapScreen()));
              }),
          Divider(),
           ListTile(
              leading: Icon(Icons.map, color: Colors.black),
              title: Text('Ingredient List'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Ingredient()));
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.adb, color: Colors.black),
              title: Text('About'),
              onTap: () {
                Navigator.pop(context);
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.help_outline, color: Colors.black),
              title: Text('Help'),
              onTap: () {
                Navigator.pop(context);
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.black),
              title: Text('Log Out'),
              onTap: () {
                Navigator.pop(context);
                _logOutAlert();
              }),
          Divider(),
        ],
      ),
    );
  }

  Future<void> _logOutAlert() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Text(
            'Log Out',
            textScaleFactor: 1.2,
          ),
          content: Text(
            'Are you sure ?',
            textScaleFactor: 1,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                _logout();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Regret'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _userAlert() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Text(
            'Hello $name',
            textScaleFactor: 1.2,
          ),
          content: Text(
            'Whom should I assist?',
            textScaleFactor: 1,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Me'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatBot(name, null)));
              },
            ),
            FlatButton(
              child: Text('Others'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatBot(name, 'Hi')));
              },
            ),
          ],
        );
      },
    );
  }

  void _logout() async {
    final database = Provider.of<AppDatabase>(context, listen: false);
    await database.resetDb();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ));
  }

  _checkConnection() async {
    await DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          Toast.show('You are online', context, gravity: Toast.CENTER);
          break;
        case DataConnectionStatus.disconnected:
          Toast.show('You are offline', context, gravity: Toast.CENTER);
          break;
      }
    });
    await DataConnectionChecker().checkInterval;
  }

  Widget text(String txt, double fSize, Color color) {
    return Text(txt,
        style: TextStyle(
          color: Colors.green,
          fontSize: fSize,
          fontFamily: "Montserrat",
          letterSpacing: 0.5,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.cyan),
      ),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
          duration: const Duration(milliseconds: 500),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height - 120,
                child: ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            text('Health',30.0,Colors.green),
                            text('Hacks',30.0,Colors.black),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            text('The',15.0,Colors.black),
                            text('Siddha',15.0,Colors.green),
                            text('way',15.0,Colors.black),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      drawer: _drawer(),
      floatingActionButton: FloatingActionButton.extended(
          heroTag: 'chatScreen',
          label: Text(
            'Ask here',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(
            Icons.chat_bubble_outline,
            color: Colors.white,
          ),
          onPressed: () {
            _userAlert();
          }),
    );
  }
}
