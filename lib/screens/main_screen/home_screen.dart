import 'package:flutter/material.dart';
import 'package:pr_doctor/screens/botscreen/bot.dart';
import 'package:pr_doctor/screens/login/login_page.dart';
import 'package:provider/provider.dart';
import 'package:pr_doctor/database/database.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name;
  TextEditingController _changedName = TextEditingController();
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          title: Text(
            'Hello $name',
            textScaleFactor: 1.2,
          ),
          content: Text(
            'Who do I assist with?',
            textScaleFactor: 1,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Me'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatBot(name,null)));
              },
            ),
            FlatButton(
              child: Text('Others'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatBot(name,'Hi')));
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
                            Text("Health",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 30.0,
                                  fontFamily: "Montserrat",
                                  letterSpacing: 0.5,
                                )),
                            Text("Hacks",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30.0,
                                  fontFamily: "Montserrat",
                                  letterSpacing: 0.5,
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("The ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  fontFamily: "Montserrat",
                                  letterSpacing: 0.5,
                                )),
                            Text("Siddha ",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 15.0,
                                  fontFamily: "Montserrat",
                                  letterSpacing: 0.5,
                                )),
                            Text("way",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  fontFamily: "Montserrat",
                                  letterSpacing: 0.5,
                                )),
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
