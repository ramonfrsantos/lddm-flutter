import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

var language;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatbot Flutter',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Chatbot'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void response(query) async {
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/service.json").build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: language);
    AIResponse aiResponse = await dialogflow.detectIntent(query);
    setState(() {
      messsages.insert(0, {
        "data": 0,
        "message": aiResponse.getListMessage()[0]["text"]["text"][0].toString()
      });
    });

    print(aiResponse.getListMessage()[0]["text"]["text"][0].toString());
  }

  final messageInsert = TextEditingController();
  List<Map> messsages = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chat bot",
        ),
      ),
      body: _buildStructure(),
    );
  }

  _buildStructure() {
    bool ptDisabled = false;
    bool enDisabled = true;

    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 15, bottom: 10),
            child: Column(
              children: [
                Text(
                  "Hoje, ${DateFormat("Hm").format(DateTime.now())}",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     RaisedButton(
                //       onPressed: () {
                //         ptDisabled = false;
                //         enDisabled = true;
                //         language = Language.portugueseBrazilian;
                //       },
                //       child: Text("pt-BR"),
                //       color: ptDisabled ? Colors.grey : Colors.blueAccent,
                //     ),
                //     SizedBox(
                //       width: 35,
                //     ),
                //     RaisedButton(
                //       onPressed: () {
                //         enDisabled = false;
                //         ptDisabled = true;
                //         language = Language.english;
                //       },
                //       child: Text("en-US"),
                //       color: enDisabled ? Colors.grey : Colors.blueAccent,
                //     ),
                //   ],
                // )
              ],
            ),
          ),
          Flexible(
              child: ListView.builder(
                  reverse: true,
                  itemCount: messsages.length,
                  itemBuilder: (context, index) => chat(
                      messsages[index]["message"].toString(),
                      messsages[index]["data"]))),
          SizedBox(
            height: 20,
          ),
          Divider(
            height: 5.0,
            color: Colors.greenAccent,
          ),
          Container(
            child: ListTile(
              leading: IconButton(
                icon: Icon(
                  Icons.camera_alt,
                  color: Colors.greenAccent,
                  size: 35,
                ),
              ),
              title: Container(
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Color.fromRGBO(220, 220, 220, 1),
                ),
                padding: EdgeInsets.only(left: 15),
                child: TextFormField(
                  controller: messageInsert,
                  decoration: InputDecoration(
                    hintText: "Digite uma mensagem...",
                    hintStyle: TextStyle(color: Colors.black26),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  onChanged: (value) {},
                ),
              ),
              trailing: IconButton(
                  icon: Icon(
                    Icons.send,
                    size: 30.0,
                    color: Colors.greenAccent,
                  ),
                  onPressed: () {
                    if (messageInsert.text.isEmpty) {
                      print("mensagem em branco");
                    } else {
                      setState(() {
                        messsages.insert(0, {
                          "data": 1,
                          "message": messageInsert.text
                              .replaceAll('vc', 'você')
                              .replaceAll('mt', 'muito')
                        });
                      });
                      response(messageInsert.text);
                      messageInsert.clear();
                    }
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  }),
            ),
          ),
          SizedBox(
            height: 15.0,
          )
        ],
      ),
    );
  }

  Widget chat(String message, int data) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment:
            data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          data == 0
              ? Container(
                  height: 60,
                  width: 60,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/robot.jpg"),
                  ),
                )
              : Container(),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Bubble(
                radius: Radius.circular(15.0),
                color: data == 0
                    ? Color.fromRGBO(23, 157, 139, 1)
                    : Colors.orangeAccent,
                elevation: 0.0,
                child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                          child: Container(
                        constraints: BoxConstraints(maxWidth: 200),
                        child: Text(
                          message,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ))
                    ],
                  ),
                )),
          ),
          data == 1
              ? Container(
                  height: 60,
                  width: 60,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/default.jpg"),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
