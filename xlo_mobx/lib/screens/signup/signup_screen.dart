import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/components/error_box.dart';
import 'package:xlo_mobx/screens/signup/components/field_title.dart';
import 'package:xlo_mobx/stores/signup_store.dart';

import '../../main.dart';

class SignUpScreen extends StatelessWidget {
  final SignupStore signupStore = SignupStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 32, right: 32),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Card(
              color: secondaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 8,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Observer(builder: (_) {
                      return Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 15),
                          child: signupStore.userChecked
                              ? MessageBox(
                                  error: signupStore.error,
                                )
                              : Container());
                    }),
                    FieldTitle(
                      title: 'Apelido',
                      subtitle: 'Como aparecerá em seus anúncios.',
                    ),
                    Observer(builder: (_) {
                      return TextField(
                        enabled: !signupStore.loading,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            hintText: 'Ex: Pedro H. Silva',
                            isDense: true,
                            errorText: signupStore.nameError),
                        onChanged: signupStore.setName,
                      );
                    }),
                    SizedBox(
                      height: 16,
                    ),
                    FieldTitle(
                      title: 'E-mail',
                      subtitle: 'Enviaremos um e-mail de confirmação.',
                    ),
                    Observer(
                      builder: (_) {
                        return TextField(
                          enabled: !signupStore.loading,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              hintText: 'Ex: pedrosilva@gmail.com',
                              isDense: true,
                              errorText: signupStore.emailError),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          onChanged: signupStore.setEmail,
                        );
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    FieldTitle(
                      title: 'Celular',
                      subtitle: 'Proteja sua conta.',
                    ),
                    Observer(builder: (_) {
                      return TextField(
                        enabled: !signupStore.loading,
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter()
                        ],
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            hintText: 'Ex: (99) 99999-9999',
                            isDense: true,
                            errorText: signupStore.phoneError),
                        keyboardType: TextInputType.phone,
                        onChanged: signupStore.setPhone,
                      );
                    }),
                    SizedBox(
                      height: 16,
                    ),
                    FieldTitle(
                      title: 'Senha',
                      subtitle: 'Use letras, números e caracteres especiais.',
                    ),
                    Observer(builder: (_) {
                      return TextField(
                        enabled: !signupStore.loading,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            isDense: true,
                            errorText: signupStore.pass1Error),
                        obscureText: true,
                        onChanged: signupStore.setPass1,
                      );
                    }),
                    SizedBox(
                      height: 16,
                    ),
                    FieldTitle(
                      title: 'Confirmar Senha',
                      subtitle: 'Repita a senha.',
                    ),
                    Observer(builder: (_) {
                      return TextField(
                        enabled: !signupStore.loading,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            isDense: true,
                            errorText: signupStore.pass2Error),
                        obscureText: true,
                        onChanged: signupStore.setPass2,
                      );
                    }),
                    SizedBox(
                      height: 8,
                    ),
                    Observer(builder: (_) {
                      return Container(
                        height: 40,
                        margin: EdgeInsets.only(top: 15, bottom: 10),
                        child: RaisedButton(
                            color: heavyColor,
                            disabledColor: heavyColor.withAlpha(120),
                            child: signupStore.loading
                                ? CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.white),
                                  )
                                : Text('CADASTRAR'),
                            textColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            onPressed: signupStore.signUpPressed),
                      );
                    }),
                    Divider(
                      color: Colors.black,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Text(
                            'Já tem conta? ',
                            style: TextStyle(fontSize: 16, color: letterColor),
                          ),
                          GestureDetector(
                            onTap: Navigator.of(context).pop,
                            child: Text(
                              'Entrar',
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
