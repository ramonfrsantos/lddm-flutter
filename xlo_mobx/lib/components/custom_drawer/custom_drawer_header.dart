import 'package:flutter/material.dart';
import 'package:xlo_mobx/screens/login/login_screen.dart';

import '../../main.dart';

class CustomDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pop();
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => LoginScreen())
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 95,
        color: mainColor,
        child: Row(
          children: [
            Icon(Icons.person, color: heavyColor, size: 35,),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Acesse sua conta agora!',
                    style: TextStyle(
                      color: heavyColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Clique aqui',
                    style: TextStyle(
                      color: heavyColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
