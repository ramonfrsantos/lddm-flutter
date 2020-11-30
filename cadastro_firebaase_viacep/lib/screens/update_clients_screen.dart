import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UpdateClientScreen extends StatefulWidget {
  var docId;

  UpdateClientScreen(this.docId);

  @override
  _UpdateClientScreenState createState() => _UpdateClientScreenState();
}

class _UpdateClientScreenState extends State<UpdateClientScreen> {
  TextEditingController txtNome = TextEditingController();
  TextEditingController txtEmail = TextEditingController();

  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          "Alterar cadastro",
          style: TextStyle(
            fontSize: 30,
            fontFamily: "BigFish",
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildName(),
              _buildEmail(),
              SizedBox(
                height: 60,
              ),
              SizedBox(
                height: 40,
                width: 110,
                child: RaisedButton(
                  color: Colors.black,
                  child: Text(
                    'Alterar',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () async {
                    db.collection('clientes').doc(widget.docId).update({
                      "nome": "${txtNome.text}",
                      "email": "${txtEmail.text}",
                    });

                    Navigator.pop(context);
                    Navigator.pop(context);

                    return showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return _buildAlertDialog();
                        });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAlertDialog() {
    return AlertDialog(
      title: Text(
        "Pronto",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w900,
        ),
        textAlign: TextAlign.center,
      ),
      content: Text(
        "O cadastro foi alterado com sucesso!",
        style: TextStyle(
          fontSize: 18,
        ),
        textAlign: TextAlign.center,
      ),
      contentPadding:
          EdgeInsets.only(left: 20, top: 30.0, right: 20, bottom: 40),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
    );
  }

  Widget _buildName() {
    return TextField(
      controller: txtNome,
      decoration: InputDecoration(
        labelText: 'Novo nome',
      ),
    );
  }

  Widget _buildEmail() {
    return TextField(
      controller: txtEmail,
      decoration: InputDecoration(
        labelText: 'Novo e-mail',
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }
}
