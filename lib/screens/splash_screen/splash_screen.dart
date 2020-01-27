import 'package:flutter/material.dart';
import 'package:pr_doctor/screens/main_screen/home_screen.dart';
import 'dart:async';
import 'package:shimmer/shimmer.dart';
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

  validate() async {
    final database = Provider.of<AppDatabase>(context, listen: false);
    if (await database.getAllData() == null) {
      navigationPage(LoginPage());
    } else {
      navigationPage(HomeScreen());
    }
  }

  Future<bool> _mockCheckForSession() async {
    await Future.delayed(Duration(seconds: 3), () {});

    return true;
  }

  @override
  void initState() {
    super.initState();
    _mockCheckForSession().then((onValue){
      validate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Opacity(opacity: 0.5,),
            Shimmer.fromColors(
              period: Duration(milliseconds: 1500),
              baseColor: Colors.cyan,
              highlightColor: Colors.cyan[100],
              child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Text(
                          "PR Doctor",
                          style: TextStyle(
                              fontSize: 60.0,
                              fontFamily: 'Pacifico',
                              shadows: <Shadow>[
                                Shadow(
                                    blurRadius: 18.0,
                                    color: Colors.black87,
                                    offset: Offset.fromDirection(120, 12))
                              ]),
                        ),
                      ),
                      Text('Your personal assistant',textScaleFactor: 1,)
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
