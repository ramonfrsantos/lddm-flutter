import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pagantesController = TextEditingController();
  TextEditingController contaController = TextEditingController();
  TextEditingController comissaoController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Preencha os dados do formulário.";

  void _resetFields() {
    pagantesController.text = "";
    contaController.text = "";
    comissaoController.text = "";
    setState(() {
      _infoText = "Preencha os dados do formulário.";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {

    setState(() {
      double pagantes = double.parse(pagantesController.text);
      double totalConta = double.parse(contaController.text);
      double comissao = double.parse(comissaoController.text);
      double parteGarcom = (totalConta * comissao / 100);
      double parteTotal = (totalConta + parteGarcom);
      double partePessoa = (parteTotal / pagantes);

      _infoText = "Valor por pessoa: R\$${partePessoa.toStringAsFixed(2)}\n";
      _infoText += "Valor total + Comissão: R\$${parteTotal.toStringAsFixed(2)}\n";
      _infoText += "Valor da comissão: R\$${parteGarcom.toStringAsFixed(2)}\n";

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "APP Racha-Conta",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.orange,
          actions: <Widget>[
            IconButton(
              color: Colors.black,
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(Icons.group, size: 120.0, color: Colors.orange),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Valor total da conta:",
                        labelStyle: TextStyle(color: Colors.black)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 25.0),
                    controller: contaController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira o valor total da conta!";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Porcentagem do garçom:",
                        labelStyle: TextStyle(color: Colors.black)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 25.0),
                    controller: comissaoController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira a porcentagem da comissão!";
                      }
                    },
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Valor total de pagantes:",
                          labelStyle: TextStyle(color: Colors.black)),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 25.0),
                      controller: pagantesController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira o número de pagantes!";
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _calculate();
                          }
                        },
                        child: Text(
                          "Calcular",
                          style: TextStyle(color: Colors.black, fontSize: 25.0),
                        ),
                        color: Colors.orange,
                      ),
                    ),
                  ),
                  Text(
                    _infoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 25.0),
                  )
                ],
              ),
            )));
  }
}
