import 'package:cadastro_firebaase_viacep/widgets/list_card_widget.dart';
import 'package:flutter/material.dart';

class ClientsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          "Clientes cadastrados",
          style: TextStyle(
            fontSize: 25,
            fontFamily: "BigFish",
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 32, top: 20, right: 32, bottom: 50),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: ListCard(),
            ),
          ),
        ),
      ),
    );
  }
}
