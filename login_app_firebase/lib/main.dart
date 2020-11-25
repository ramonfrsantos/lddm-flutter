import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/authentication.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Authentication(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login App',
        theme: ThemeData(
          primaryColor: Colors.blue,
        ),
        home: LoginScreen(),
        routes: {
          SignupScreen.routeName: (ctx) => SignupScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
        },
      ),
    );
  }
}
