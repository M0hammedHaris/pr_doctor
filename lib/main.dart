import 'package:flutter/material.dart';

import 'screens/login/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: LoginPage(title: 'Flutter Demo Home Page'),
    );
  }
}