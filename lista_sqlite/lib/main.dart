import 'package:flutter/material.dart';
import 'package:lista_sqlite/screens/teste_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CRUD em SQLite',
      home: TestePage(),
    );
  }
}
