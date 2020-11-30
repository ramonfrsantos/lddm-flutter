import 'package:bordered_text/bordered_text.dart';
import 'package:cadastro_firebaase_viacep/screens/clients_list_screen.dart';
import 'package:cadastro_firebaase_viacep/screens/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_plus/flutter_plus_exports.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _width = 80;
  double _height = 80;
  double _radius = 100;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isExpanded
          ? AppBar(
              toolbarHeight: 100,
              title: Text(
                "Sobre os clientes...",
                style: TextStyle(
                  fontSize: 35,
                  fontFamily: "BigFish",
                ),
              ),
              elevation: 0,
              centerTitle: true,
            )
          : null,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isExpanded
                ? Container()
                : SizedBox(
                    width: 320,
                    child: BorderedText(
                      strokeWidth: 8,
                      strokeColor: Colors.black,
                      child: Text(
                        "Aperte o botão!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 80,
                            fontFamily: 'Bigfish'),
                      ),
                    ),
                  ),
            isExpanded
                ? Container()
                : SizedBox(
                    height: 80,
                  ),
            AnimatedContainer(
              height: _height,
              width: _width,
              duration: Duration(milliseconds: 800),
              child: ContainerPlus(
                  color: isExpanded ? Colors.white : Colors.green,
                  border: BorderPlus(color: Colors.white, width: 2),
                  shadows: [
                    ShadowPlus(
                      color: isExpanded ? Colors.purple : Colors.yellow,
                      opacity: 0.6,
                      blur: 6,
                      spread: isExpanded ? 8 : 5,
                    )
                  ],
                  radius: RadiusPlus.all(_radius),
                  onTap: () {
                    _radius = 100;
                    setState(() {
                      if (isExpanded) {
                        isExpanded = false;
                        _width = 80;
                        _height = 80;
                      } else {
                        isExpanded = true;
                        _width = 250;
                        _height = 400;
                        _radius = 20;
                      }
                    });
                  },
                  child: isExpanded
                      ? ContainerPlus(
                          radius: RadiusPlus.all(20),
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            margin: EdgeInsets.all(10),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SizedBox(
                                    height: 100,
                                  ),
                                  ContainerPlus(
                                    radius: RadiusPlus.all(50),
                                    height: 60,
                                    width: 180,
                                    color: Colors.black,
                                    child: RaisedButton(
                                        color: Colors.black,
                                        child: Text(
                                          "Cadastrar",
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SignUpScreen()));
                                        }),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  ContainerPlus(
                                    radius: RadiusPlus.all(50),
                                    height: 60,
                                    width: 180,
                                    color: Colors.black,
                                    child: RaisedButton(
                                        color: Colors.black,
                                        child: Text(
                                          "Listar",
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ClientsListScreen()));
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Icon(
                          Icons.fingerprint,
                          size: 60,
                        )),
            ),
          ],
        ),
      ),
    );
  }
}
