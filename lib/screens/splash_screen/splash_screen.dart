import 'package:flutter/material.dart';
import 'package:pr_doctor/screens/main_screen/home_screen.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:pr_doctor/database/database.dart';
import 'package:pr_doctor/screens/login/login_page.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void navigationPage(page) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => page));
  }

 validate() async{
    final database = Provider.of<AppDatabase>(context, listen: false);
      if (database.getAllData() ==null){
        navigationPage(LoginPage());
      }
      else{
        navigationPage(HomeScreen());
      }
  }
  @override
void initState() {
  super.initState();
  validate();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
      child:Text(
        'Splach',
        textScaleFactor: 2.0,
      )
    ),
    );
  }
}
