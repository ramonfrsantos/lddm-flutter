import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmailButton extends StatelessWidget {
  final double valor;

  EmailButton(this.valor);

  @override
  Widget build(BuildContext context) {
    String message = "Estão fazendo ${valor.toInt()} graus.";
    String mails = 'ramon_r_santos@hotmail.com,'
        'gustavolemosdossantos06@gmail.com,'
        'ramonfrsantos@gmail.com,'
        'camposjoao177@gmail.com, '
        'bernardo_ragonezi@hotmail.com';

    return SizedBox(
      width: 350,
      height: 60,
      child: Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: RaisedButton(
            elevation: 8,
            child: Text(
              'Enviar email com as informações',
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
              final Uri _emailLaunchUri = Uri(
                scheme: 'mailto',
                path: '$mails',
                queryParameters: {
                  'subject':
                      '[Mon&Com] Estamos enviando informações do monitoramento.',
                  'body': '$message'
                },
              );

              launch(_emailLaunchUri.toString());
            }),
      ),
    );
  }
}
