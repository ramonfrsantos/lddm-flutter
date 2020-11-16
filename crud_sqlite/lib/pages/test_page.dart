import 'dart:async';

import 'package:crud_sqlite/helpers/db_helper.dart';
import 'package:crud_sqlite/helpers/produto.dart';
import 'package:flutter/material.dart';

class TestePage extends StatefulWidget {
  final String title;

  TestePage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TestePageState();
  }
}

class _TestePageState extends State<TestePage> {
  //
  Future<List<Produto>> produtos;
  TextEditingController controller = TextEditingController();
  String name;
  int currentUserId;

  final formKey = new GlobalKey<FormState>();
  var database;
  bool isUpdating;

  @override
  void initState() {
    super.initState();
    database = DBHelper();
    isUpdating = false;
    refreshList();
  }

  refreshList() {
    setState(() {
      produtos = database.getProdutos();
    });
  }

  clearNome() {
    controller.text = '';
  }

  validate() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (isUpdating) {
        Produto e = Produto(currentUserId, name);
        database.update(e);
        setState(() {
          isUpdating = false;
        });
      } else {
        Produto e = Produto(null, name);
        database.save(e);
      }
      clearNome();
      refreshList();
    }
  }

  form() {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.only(left: 50, top: 25, right: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            TextFormField(
              controller: controller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Nome do produto'),
              validator: (val) => val.length == 0 ? 'Digite o name' : null,
              onSaved: (val) => name = val,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  onPressed: validate,
                  child: Text(isUpdating ? 'UPDATE' : 'ADICIONAR'),
                ),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      isUpdating = false;
                    });
                    clearNome();
                  },
                  child: Text('CANCELAR'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView dataTable(List<Produto> produtos) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: EdgeInsets.only(top: 60),
        child: SizedBox(
          height: 400,
          width: 300,
          child: Card(
            elevation: 8,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: DataTable(
              columns: [
                DataColumn(
                  label: Text('PRODUTO'),
                ),
                DataColumn(
                  label: Text('EXCLUIR'),
                )
              ],
              rows: produtos
                  .map(
                    (produto) => DataRow(cells: [
                      DataCell(
                        Text(produto.name),
                        onTap: () {
                          setState(() {
                            isUpdating = true;
                            currentUserId = produto.id;
                          });
                          controller.text = produto.name;
                        },
                      ),
                      DataCell(IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          database.delete(produto.id);
                          refreshList();
                        },
                      )),
                    ]),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  list() {
    return Expanded(
      child: FutureBuilder(
        future: produtos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return dataTable(snapshot.data);
          }

          if (null == snapshot.data || snapshot.data.length == 0) {
            return Text("Nenhum dado encontrado.");
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Lista de Compras'),
        centerTitle: true,
      ),
      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            form(),
            list(),
          ],
        ),
      ),
    );
  }
}
