import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/screens/login/login_screen.dart';
import 'package:xlo_mobx/stores/page_store.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

import '../../main.dart';

class CustomDrawerHeader extends StatelessWidget {

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pop();

        if(userManagerStore.isLoggedIn){
          GetIt.I<PageStore>().setPage(4);
        } else {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => LoginScreen())
          );
        }
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
                    userManagerStore.isLoggedIn
                      ? 'Olá ${userManagerStore.user.name.split(" ")[0]}!'
                        : 'Acesse sua conta agora!',
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
                    userManagerStore.isLoggedIn
                        ? 'Seja bem vindo(a)!'
                        : 'Clique aqui',
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
