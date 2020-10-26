import 'package:flutter/material.dart';
import 'package:lista_itens_mvc/controllers/item.controller.dart';
import 'package:lista_itens_mvc/models/item.model.dart';

class ItemListView extends StatefulWidget {
  @override
  _ItemListViewState createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
  final _formKey = GlobalKey<FormState>();
  var _itemController = TextEditingController();
  var _list = List<Item>();
  var _controller = ItemController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.getAll().then((data) {
        setState(() {
          _list = _controller.list;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: ListView(
          children: [
            for (int i = 0; i < _list.length; i++)
              ListTile(
                  title: CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: _list[i].concluido
                    ? Text(
                        _list[i].nome,
                        style:
                            TextStyle(decoration: TextDecoration.lineThrough),
                      )
                    : Text(_list[i].nome),
                value: _list[i].concluido,
                secondary: IconButton(
                  icon: Icon(
                    Icons.delete,
                    size: 20.0,
                    color: Colors.red[900],
                  ),
                  onPressed: () {
                    _controller.delete(i).then((data) {
                      setState(() {
                        _list = _controller.list;
                      });
                    });
                  },
                ),
                onChanged: (c) {
                  _list[i].concluido = c;
                  _controller.updateList(_list).then((data) {
                    setState(() {
                      _list = _controller.list;
                    });
                  });
                },
              )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _displayDialog(context),
      ),
    );
  }

  _displayDialog(context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Form(
              key: _formKey,
              child: TextFormField(
                controller: _itemController,
                validator: (s) {
                  if (s.isEmpty)
                    return "Digite o item.";
                  else
                    return null;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "Digite o item a ser adicionado:"),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: new Text('CANCELAR'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: new Text('SALVAR'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _controller
                        .create(
                            Item(nome: _itemController.text, concluido: false))
                        .then((data) {
                      setState(() {
                        _list = _controller.list;
                        _itemController.text = "";
                      });
                    });
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          );
        });
  }
}
