import 'package:flutter/material.dart';
import 'package:pr_doctor/database/database.dart';
import 'package:pr_doctor/screens/main_screen/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import 'faded_animation.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _userName = TextEditingController();
  TextEditingController _age = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              height: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage('assets/images/undraw_medicine_b1ol.png'),
                      fit: BoxFit.contain)),
            ),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  FadeAnimation(
                      1.5,
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, .25),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10))
                            ]),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[100]))),
                              child: TextField(
                                controller: _userName,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "User Name",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400])),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _age,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Age",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400])),
                              ),
                            )
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  FadeAnimation(
                      1.8,
                      GestureDetector(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: [
                                Colors.cyan,
                                Colors.cyan[200],
                              ])),
                          child: Center(
                            child: Text(
                              "Get Started",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textScaleFactor: 1.4,
                            ),
                          ),
                        ),
                        onTap: () async {
                          if (_userName.text != '' && _age.text != '') {
                            _navigate(_userName.text, _age.text);
                          } else {
                            Toast.show("Enter user name and age", context,
                                gravity: Toast.CENTER,
                                duration: Toast.LENGTH_LONG);
                          }
                        },
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _navigate(String name, String age) async {
    final database = Provider.of<AppDatabase>(context, listen: false);
    final data = DataBase(id: 1, userName: name, age: age, validate: true);
    await database.insertTask(data);
    if (data.validate) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
    }
  }
}
