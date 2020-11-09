import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CadastroScreen extends StatelessWidget {
  final txtEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(txtEmail);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: TextField(
          controller: txtEmail,
          decoration: InputDecoration(
            icon: Icon(Icons.send),
            hintText: 'Digite o e-mail:',
            helperText: 'O e-mail digitado será inserido na lista de envios.',
            border: const OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
