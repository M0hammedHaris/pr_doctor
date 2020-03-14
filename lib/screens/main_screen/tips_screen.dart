import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pr_doctor/database/data_classes.dart';
import 'package:pr_doctor/screens/main_screen/tips_description.dart';
class TipsScreen extends StatefulWidget {
  TipsScreen(this.url);
  final String url;
  @override
  _TipsScreenState createState() => _TipsScreenState();
}

class _TipsScreenState extends State<TipsScreen> {

  List<TipsList> _tipsList = List<TipsList>();

  Future<List<TipsList>> fetchNotes() async {
    var response = await http.get(widget.url);

    var tipsList = List<TipsList>();

    if (response.statusCode == 200) {
      var tipsListJson = json.decode(response.body);
      for (var tipsListJson in tipsListJson) {
        tipsList.add(TipsList.fromJson(tipsListJson));
      }
    }
    return tipsList;
  }

   @override
  void initState() {
    fetchNotes().then((value) {
      setState(() {
        _tipsList.addAll(value);
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: _tipsList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _tipsList[index].title,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      _tipsList[index].content,
                      style: TextStyle(
                        color: Colors.grey[600]
                      ),
                    ),
                  ],
                ),
              ),
            ),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => TipsDescription(desc: _tipsList[index].desc,)));
            }
          );
        },
      )
    );
  }
}