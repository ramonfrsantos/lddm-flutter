import 'package:flutter/material.dart';
import 'package:monecom/components/paisagem_view.dart';

class MonitoraScreen extends StatelessWidget {
  final double temp;
  MonitoraScreen(this.temp);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Monitoramento',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                "A temperatura atual é de $temp ºC.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            PaisagemView(temp),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
