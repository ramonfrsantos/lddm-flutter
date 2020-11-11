import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:monecom/library/models/mysql.dart';

import '../main.dart';

class GadoInfoScreen extends StatefulWidget {
  @override
  _GadoInfoScreenState createState() => _GadoInfoScreenState();
}

class _GadoInfoScreenState extends State<GadoInfoScreen> {
  var db = Mysql();
  var statusSensor;
  var idSensor;
  var data;

  void _getData() {
    db.getConnection().then((conn) {
      String sql =
          'select statusSensor,idSensor, data from registrosIot where idSensor = 3;';
      conn.query(sql).then((results) {
        for (var row in results) {
          setState(() {
            statusSensor = row[0];
            data = row[2];
            idSensor = row[1];
          });
        }
      });
      conn.close();
    });
  }

  @override
  Widget build(BuildContext context) {
    _getData();

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.8,
        title: Text(
          "Monitoramento",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
          child: SizedBox(
        height: 380,
        width: 340,
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
            color: shrineBlack100,
            elevation: 10,
            clipBehavior: Clip.antiAlias,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(22),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    BorderedText(
                      strokeColor: shrinePurple900,
                      strokeWidth: 10.0,
                      child: Text(
                        "Informações do sensor",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontFamily: 'UniSans-Heavy'),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 80,
                          ),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                              text: "ID do Sensor: ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: "$idSensor",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal),
                            )
                          ])),
                          SizedBox(
                            height: 20,
                          ),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                              text: "Área de acionamento: ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: "$statusSensor",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal),
                            )
                          ])),
                          SizedBox(
                            height: 20,
                          ),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                              text: "Data e hora: ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: "$data",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal),
                            )
                          ])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }
}