import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'item_list.view.dart';

class BuildTheme extends StatefulWidget {
  @override
  _BuildThemeState createState() => _BuildThemeState();
}

class _BuildThemeState extends State<BuildTheme> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _themeData,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Lista de items'),
          centerTitle: true,
          actions: [_PopupMenuButton()],
        ),
        body: ItemListView(),
      ),
    );
  }

  String _theme = 'Light';
  var _themeData = ThemeData.light();

  @override
  void initState() {
    super.initState();
    _getTheme();
  }

  _getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _theme = (prefs.getString('theme') ?? 'Light');
      _themeData = _theme == 'Dark' ? ThemeData.dark() : ThemeData.light();
    });
  }

  _setTheme(theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _theme = theme;
      _themeData = theme == 'Dark' ? ThemeData.dark() : ThemeData.light();
      prefs.setString('theme', theme);
    });
  }

  _PopupMenuButton() {
    return PopupMenuButton(
      onSelected: (value) => _setTheme(value),
      itemBuilder: (context) {
        var list = List<PopupMenuEntry<Object>>();
        list.add(
          PopupMenuItem(child: Text("Escolher Tema")),
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
}
