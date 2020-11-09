import 'package:flutter/material.dart';
import 'package:monecom/ui/screens/cadastro_screen.dart';

class CadastroButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String mails = '';
    String mail = '';

    for (int i = 0; i < mails.length; i++) {
      mails = '${mail[i]}';
    }

    return SizedBox(
      width: 350,
      height: 60,
      child: Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: RaisedButton(
            elevation: 8,
            child: Text(
              'Cadastrar e-mail na lista',
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            onPressed: () {
              return Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CadastroScreen()));
            }),
      ),
    );
  }
}
