import 'package:flutter/material.dart';
import 'package:lista_itens_mvc/ui/themes_view.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  BuildTheme _buildTheme = BuildTheme();

  @override
  Widget build(BuildContext context) {
    return _buildTheme;
  }
}
