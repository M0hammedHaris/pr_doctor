import 'package:flutter/material.dart';
import 'package:pr_doctor/screens/botscreen/message_format.dart';
import 'package:flutter_dialogflow_v2/flutter_dialogflow.dart';
import 'package:speech_recognition/speech_recognition.dart';

class ChatBot extends StatefulWidget {
  ChatBot(this.userName);
  final String userName;
  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final List<MessageFormat> _messages = <MessageFormat>[];
  TextEditingController _messageQuery;
  bool _buttonEnabled = false, _speechEnabled = false;

  SpeechRecognition _speechRecognition;
  bool _isAvailable = false, _isListening = false;
  String resultText = '';

  void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();
    _speechRecognition.setAvailabilityHandler((result) {
      setState(() {
        _isAvailable = result;
      });
    });

    _speechRecognition.setRecognitionStartedHandler(() {
      setState(() => _isListening = true);
    });

    _speechRecognition.setRecognitionResultHandler((text) {
      setState(() => resultText = text);
    });

    _speechRecognition.setRecognitionCompleteHandler((value) {
      setState(() => _isListening = false);
    });

    _speechRecognition
        .activate()
        .then((value) => setState(() => _isAvailable = value));
  }

  @override
  void initState() {
    super.initState();
    initSpeechRecognizer();
    _messageQuery = new TextEditingController();
  }

  Widget _queryInputWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.mic,
                  color: Colors.white,
                  size: 30.0,
                ),
              ),
              decoration:
                  BoxDecoration(color: Colors.cyan, shape: BoxShape.circle),
            ),
            onTap: () {
              if (_isAvailable && !_isListening) {
                _speechRecognition
                    .listen(locale: "en_US")
                    .then((value) => setState(() {
                          _speechEnabled = true;
                          _buttonEnabled = true;
                        }));
              }
            },
          ),
          Flexible(
            child: _speechEnabled
                ? Text(resultText)
                : TextField(
                    controller: _messageQuery,
                    onChanged: (value) {
                      {
                        setState(() {
                          _buttonEnabled = true;
                        });
                      }
                    },
                    decoration: InputDecoration.collapsed(
                        hintText: "Tell me your health issue"),
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
                  String _query =
                      _speechEnabled ? resultText : _messageQuery.text;
                  _buttonEnabled ? _submitQuery(_query) : null;
                  setState(() {
                    resultText = '';
                    _speechEnabled = false;
                  });
                }),
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
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
      _buttonEnabled = false;
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
          style: TextStyle(color: Colors.cyan),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.cyan),
        elevation: 0,
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
