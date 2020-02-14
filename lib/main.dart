import 'package:flutter/material.dart';
import 'package:pr_doctor/screens/splash_screen/splash_screen.dart';
import 'database/database.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (_) => AppDatabase(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'PR.Doctor',
          theme: ThemeData(
            primaryColor: Colors.cyan,
            accentColor: Colors.cyan[400]
          ),
          home: SplashScreen(),
        ));
  }
}
