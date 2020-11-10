import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:monecom/stores/cadastro_store.dart';

class CadastroScreen extends StatelessWidget {
  final CadastroStore cadastroStore = GetIt.I<CadastroStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cadastro',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
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
                height: 100,
              ),
              Observer(
                builder: (_) {
                  return RaisedButton(
                    child: Text('Enviar'),
                    onPressed: () {
                      if (cadastroStore.isFormValid) {
                        FirebaseFirestore db = FirebaseFirestore.instance;

                        db.collection("clientes").add({
                          "nome": "${cadastroStore.name}",
                          "email": "${cadastroStore.email}",
                        });

                        Navigator.pop(context);

                        return showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return _buildAlertDialog();
                            });
                      } else {
                        return null;
                      }
                    },
                  );
                },
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
        "Pronto!",
        style: TextStyle(
          fontSize: 24,
        ),
        textAlign: TextAlign.center,
      ),
      content: Text(
        "O cliente foi cadastrado com sucesso.",
        style: TextStyle(
          fontSize: 18,
        ),
        textAlign: TextAlign.center,
      ),
      contentPadding: EdgeInsets.all(50.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
    );
  }

  Widget _buildName() {
    return Observer(builder: (_) {
      return TextField(
        onChanged: cadastroStore.setName,
        decoration: InputDecoration(
          labelText: 'Nome',
          errorText: cadastroStore.nameError,
        ),
      );
    });
  }

  Widget _buildEmail() {
    return Observer(builder: (_) {
      return TextField(
        onChanged: cadastroStore.setEmail,
        decoration: InputDecoration(
          labelText: 'E-mail',
          errorText: cadastroStore.emailError,
        ),
        keyboardType: TextInputType.emailAddress,
      );
    });
  }
}
