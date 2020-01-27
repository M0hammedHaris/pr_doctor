import 'package:flutter/material.dart';
import 'package:pr_doctor/screens/botscreen/bot.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Personal Assistance',
            style: TextStyle(color: Colors.white),
          ),
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
            Text("Daily Tips",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 35.0,
                  fontFamily: "Montserrat",
                  letterSpacing: 0.5,
                )),
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.chat_bubble_outline),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ChatBot()));
          }),
    );
  }
}
