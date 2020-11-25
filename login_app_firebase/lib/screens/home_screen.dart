import 'package:flutter/material.dart';
import 'package:login_app/helpers/db_helper.dart';
import 'package:login_app/helpers/produto.dart';
import 'package:login_app/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              validator: (val) => val.length == 0 ? 'Digite o nome' : null,
              onSaved: (val) => name = val,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  onPressed: validate,
                  child: Text(isUpdating ? 'ALTERAR' : 'ADICIONAR'),
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
      child: Container(
        margin: EdgeInsets.all(24),
        padding: EdgeInsets.only(bottom: 20),
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
    );
  }

  list() {
    return SizedBox(
      height: 450,
      width: 300,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página principal'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              form(),
              SizedBox(
                height: 30,
              ),
              list(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.home),
        onPressed: () {
          return Navigator.push(
              context, MaterialPageRoute(builder: (_) => LoginScreen()));
        },
      ),
    );
  }
}
