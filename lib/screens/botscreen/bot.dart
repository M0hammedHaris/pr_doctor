import 'package:flutter/material.dart';
import 'package:pr_doctor/screens/botscreen/message_format.dart';
import 'package:flutter_dialogflow_v2/flutter_dialogflow.dart';
import 'package:toast/toast.dart';

class ChatBot extends StatefulWidget {
  ChatBot(this.userName);
  final String userName;
  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final List<MessageFormat> _messages = <MessageFormat>[];
  final TextEditingController _messageQuery = TextEditingController();
  bool _buttonEnabled = false;
  final _formkey = GlobalKey<FormState>();

  Widget _queryInputWidget(BuildContext context) {
    return Form(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextFormField(
                key: _formkey,
                controller: _messageQuery,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter the Text';
                  }
                },
                onChanged: (value) {
                  {
                    setState(() {
                      _buttonEnabled = true;
                    });
                }},
                decoration:
                    InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                  icon: Icon(
                    Icons.send,
                    color: _buttonEnabled ? Colors.cyan : Colors.grey,
                  ),
                  onPressed: () {
                      _buttonEnabled?_submitQuery(_messageQuery.text):null;
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void _submitQuery(String text) {
    _messageQuery.clear();
    MessageFormat message = new MessageFormat(
      text: text,
      name: widget.userName,
      type: true,
    );
    setState(() {
      _messages.insert(0, message);
      _buttonEnabled =false;
    });
    _dialogFlowResponse(text);
  }

  void _dialogFlowResponse(query) async {
    _messageQuery.clear();
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/pr-dr-ghjoas-c64d83ea1f39.json")
            .build();
    Dialogflow dialogFlow =
        Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse response = await dialogFlow.detectIntentFromText(query);
    print(response.getListMessage());
    MessageFormat message = MessageFormat(
      text: response.getMessage() ??
          CardDialogflow(response.getListMessage()[0]).title,
      name: "PR.DR",
      type: false,
    );
    setState(() {
      _messages.insert(0, message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Chat Bot",
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
      body: Column(children: <Widget>[
        Flexible(
            child: ListView.builder(
          padding: EdgeInsets.all(8.0),
          reverse: true, //To keep the latest messages at the bottom
          itemBuilder: (_, int index) => _messages[index],
          itemCount: _messages.length,
        )),
        Divider(height: 1.0),
        Container(
          decoration: new BoxDecoration(color: Theme.of(context).cardColor),
          child: _queryInputWidget(context),
        ),
      ]),
    );
  }
}
