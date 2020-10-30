import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:xlo_mobx/screens/base/base_screen.dart';
import 'package:xlo_mobx/stores/page_store.dart';

final mainColor = Color(0xFF1a1a2e);
final secondaryColor = Color(0xFF0f3460);
final heavyColor = Color(0xFFe94560);
final cursorColor = Color(0xFF16213e);
final letterColor = Colors.white;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeParse();
  setupLocators();
  runApp(MyApp());
}

void setupLocators(){
  GetIt.I.registerSingleton(PageStore());
}

Future<void> initializeParse() async{
  await Parse().initialize(
    'u7V1pmiAjO4u9v3hWEdMbqu2w0prmEBFR6s0TgHv',
    'https://parseapi.back4app.com/',
    clientKey: 'fn3HSvstyFS1xfRpsNaCfDuN1gv71iTXlqYJzOEt',
    autoSendSessionId: true,
    debug: true,
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'XLO',
      theme: ThemeData(
        primaryColor: mainColor,
        primaryIconTheme: IconThemeData(
            color: heavyColor
        ),
        primaryTextTheme: TextTheme(
          headline6: TextStyle(
            color: heavyColor,
            fontWeight: FontWeight.w800,
            fontFamily: 'Roboto',
            fontSize: 24
          )
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: mainColor,
        appBarTheme: AppBarTheme(
          elevation: 0,
        ),
        cursorColor: cursorColor
      ),
      home: BaseScreen(),
    );
  }
}