import 'package:flutter/material.dart';

class TipsDescription extends StatefulWidget {
  final String desc;
  TipsDescription({Key key, this.desc}) : super(key: key);

  @override
  _TipsDescriptionState createState() => _TipsDescriptionState();
}

class _TipsDescriptionState extends State<TipsDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          widget.desc,
          style: TextStyle(
            fontSize: 18.0
          ),
        ),
      ),
    );
  }
}
