import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pr_doctor/database/data_classes.dart';
class TipsScree extends StatefulWidget {
  @override
  _TipsScreeState createState() => _TipsScreeState();
}

class _TipsScreeState extends State<TipsScree> {

  List<IngredientList> _ingList = List<IngredientList>();

  Future<List<IngredientList>> fetchNotes() async {
    var url = 'https://raw.githubusercontent.com/boriszv/json/master/random_example.json';
    var response = await http.get(url);

    var ingList = List<IngredientList>();

    if (response.statusCode == 200) {
      var ingListJson = json.decode(response.body);
      for (var ingListJson in ingListJson) {
        ingList.add(IngredientList.fromJson(ingListJson));
      }
    }
    return ingList;
  }

   @override
  void initState() {
    fetchNotes().then((value) {
      setState(() {
        _ingList.addAll(value);
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _ingList.length,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.only(top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _ingList[index].title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    _ingList[index].text,
                    style: TextStyle(
                      color: Colors.grey[600]
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      )
    );
  }
}