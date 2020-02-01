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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                top: 25.0, left: 7.0, bottom: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FloatingActionButton(
                  heroTag: 'drawer',
                  elevation: 0,
                  child: const Icon(Icons.menu,color: Colors.cyan,),
                  backgroundColor: Colors.white,
                  onPressed: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                ),

                 FloatingActionButton(
                   heroTag: 'search',
                  elevation: 0,
                  child: const Icon(Icons.search,color: Colors.cyan,),
                  backgroundColor: Colors.white,
                  onPressed: () {
                  },
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(
                top: 10.0, left: 8.0 ,right: 8.0),child:Container(
            padding: EdgeInsets.only(
                top: 10.0, left: 8.0, right: 8.0),
            height: MediaQuery.of(context).size.height - 120,
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
            ),
          ))
        ],
      ),
      drawer: _drawer(),
      floatingActionButton: FloatingActionButton(
        heroTag: 'chatScreen',
          child: Icon(Icons.chat_bubble_outline),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ChatBot(name)));
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
              leading: Icon(Icons.person_pin, color: Colors.black),
              title: Text('Change Name'),
              onTap: () {
                Navigator.pop(context);
                _nameChangeAlert();
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

  Future<void> _nameChangeAlert() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Enter new name',
            textScaleFactor: 1.2,
          ),
          content: TextField(
            controller: _changedName,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "New user Name",
                hintStyle: TextStyle(color: Colors.grey[400])),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                _updateUserName();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
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

  void _updateUserName() async {
    final database = Provider.of<AppDatabase>(context, listen: false);
    final data = await database.getAllData();
    database.updateTask(
        data.copyWith(userName: _changedName.text, id: 1, validate: true));
    setState(() {
      getNameFromDb();
      _changedName.text='';
    });
  }
}
