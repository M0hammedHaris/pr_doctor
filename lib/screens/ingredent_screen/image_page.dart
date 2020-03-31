import 'package:flutter/material.dart';
import 'package:pr_doctor/database/data_classes.dart';
import 'package:pr_doctor/screens/ingredent_screen/web_browser.dart';

class ImagePage extends StatefulWidget {
  final IngredientList list;
  ImagePage({Key key, this.list}) : super(key: key);

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.list.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 320,
            width: MediaQuery.of(context).size.width,
            child: Image(image: NetworkImage(widget.list.imgUrl)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('To Know more ', textScaleFactor: 1.4),
              GestureDetector(
                child: Text('English',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue),
                    textScaleFactor: 1.4),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WebBrowser(
                                url: widget.list.wikiEn,
                              )));
                },
              ),
              Text(' or ', textScaleFactor: 1.4),
              GestureDetector(
                child: Text('Tamil.',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue),
                    textScaleFactor: 1.4),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WebBrowser(
                                url: widget.list.wikiTa,
                              )));
                },
              ),
            ],
          ),
          SizedBox(
            height: 1.0,
          )
        ],
      ),
    );
  }
}
