import 'package:flutter/material.dart';
import 'package:pr_doctor/screens/botscreen/message_format.dart';
import 'package:flutter_dialogflow_v2/flutter_dialogflow.dart';

class ChatBot extends StatefulWidget {
  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final List<MessageFormat> _messages = <MessageFormat>[];
  final TextEditingController _messageQuery = TextEditingController();

  Widget _queryInputWidget(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _messageQuery,
                onSubmitted: _submitQuery,
                decoration:
                    InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _submitQuery(_messageQuery.text)),
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
      name: "Haris",
      type: true,
    );
    setState(() {
      _messages.insert(0, message);
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
        title: Text("Chat Bot",style: TextStyle(color: Colors.white),),
      ),
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
