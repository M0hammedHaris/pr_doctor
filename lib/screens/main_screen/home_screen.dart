import 'package:flutter/material.dart';
import 'package:pr_doctor/screens/botscreen/bot.dart';
import 'package:pr_doctor/screens/login/login_page.dart';
import 'package:provider/provider.dart';
import 'package:pr_doctor/database/database.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name;

  getNameFromDb() async{
    final database = Provider.of<AppDatabase>(context, listen: false);
    final data = await database.getAllData();

  setState(() {
    name = data.userName;
  });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNameFromDb();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                Colors.cyan,
                Colors.cyan[200],
              ])))),
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(5.0),
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text("Welcome",
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
                Text(name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontFamily: "Montserrat",
                )),
              ],
            )
          ],
        ),
      )),
      drawer: _drawer(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.chat_bubble_outline),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ChatBot(name)));
          }),
    );
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
        title: Text('Log Out',textScaleFactor: 1.2,),
        content: Text('Are you sure ?',textScaleFactor: 1,),
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

void _logout() async{
  final database = Provider.of<AppDatabase>(context, listen: false);
    final data = await database.resetDb();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
}
}
