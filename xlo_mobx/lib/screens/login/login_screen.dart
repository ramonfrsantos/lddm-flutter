import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/components/message_box_login.dart';
import 'package:xlo_mobx/main.dart';
import 'package:xlo_mobx/screens/signup/signup_screen.dart';
import 'package:xlo_mobx/stores/login_store.dart';

class LoginScreen extends StatelessWidget {
  final LoginStore loginStore = LoginStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Card(
              color: secondaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              margin: EdgeInsets.symmetric(horizontal: 32),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Acessar com E-mail:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: letterColor,
                      ),
                    ),
                    Observer(builder: (_) {
                      return Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 15),
                          child: loginStore.userChecked
                              ? MessageBoxLogin(
                            error: loginStore.error,
                          )
                              : Container());
                    }),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 3, top: 8, bottom: 4),
                      child: Text(
                        'E-mail:',
                        style: TextStyle(
                            color: letterColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Observer(builder: (_) {
                      return TextField(
                        enabled: !loginStore.loading,
                        onChanged: loginStore.setEmail,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: const OutlineInputBorder(),
                            isDense: true,
                            errorText: loginStore.emailError),
                        keyboardType: TextInputType.emailAddress,
                      );
                    }),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 3, bottom: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Senha:',
                            style: TextStyle(
                                color: letterColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                          GestureDetector(
                            child: Text(
                              'Esqueceu sua senha?',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: heavyColor),
                            ),
                            onTap: () {},
                          )
                        ],
                      ),
                    ),
                    Observer(builder: (_) {
                      return TextField(
                        enabled: !loginStore.loading,
                        onChanged: loginStore.setPassword,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: const OutlineInputBorder(),
                            isDense: true,
                            errorText: loginStore.passwordError),
                        obscureText: true,
                      );
                    }),
                    SizedBox(
                      height: 22,
                    ),
                    Container(
                      height: 40,
                      margin: EdgeInsets.only(bottom: 16),
                      child: Observer(builder: (_) {
                        return RaisedButton(
                            color: heavyColor,
                            disabledColor: heavyColor.withAlpha(120),
                            child: loginStore.loading
                                ? CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.white),
                                  )
                                : Text(
                                    'ENTRAR',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                  ),
                            textColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            onPressed: loginStore.loginPressed);
                      }),
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 12, bottom: 8),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Text(
                            'Não tem cadastro? ',
                            style: TextStyle(fontSize: 16, color: letterColor),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => SignUpScreen()));
                            },
                            child: Text(
                              'Cadastre-se',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: heavyColor,
                                  fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
