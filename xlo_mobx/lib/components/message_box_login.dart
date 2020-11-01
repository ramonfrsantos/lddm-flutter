import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBoxLogin extends StatelessWidget {

  MessageBoxLogin({this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    if(error == null){
      return Container();
    } else {
      return Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(20)
        ),
        child: Row(
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.white,
              size: 40,
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                'Oops! $error. Por favor, tente novamente.',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14
                ),
              ),
            )
          ],
        ),
      );
    }
  }
}
