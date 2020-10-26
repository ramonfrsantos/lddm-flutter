import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  String _theme = 'Light';
  var _themeData = ThemeData.light();
  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

// Carregando o tema salvo pelo usuário
  _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _theme = (prefs.getString('theme') ?? 'Light');
      _themeData = _theme == 'Dark' ? ThemeData.dark() : ThemeData.light();
    });
  }

// Carregando o tema salvo pelo usuário
  _setTheme(theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _theme = theme;
      _themeData = theme == 'Dark' ? ThemeData.dark() : ThemeData.light();
      prefs.setString('theme', theme);
    });
  }

  _PopupMenuButton(){
    return PopupMenuButton(
      onSelected: (value) => _setTheme(value) ,
      itemBuilder: (context) {
        var list = List<PopupMenuEntry<Object>>();
        list.add(
          PopupMenuItem(
              child: Text("Configurar Tema")
          ),
        );
        list.add(
          PopupMenuDivider(
            height: 10,
          ),
        );
        list.add(
          CheckedPopupMenuItem(
            child: Text("Light"),
            value: 'Light',
            checked: _theme == 'Light',
          ),
        );
        list.add(
          CheckedPopupMenuItem(
            child: Text("Dark"),
            value: 'Dark',
            checked: _theme == 'Dark',
          ),
        );
        return list;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _themeData,
      home: Scaffold(
        appBar: AppBar(
          title: Text('SharedPreferences'),
          centerTitle: true,
          actions: [
            _PopupMenuButton()
          ],
        ),
      ),
    );
  }
}