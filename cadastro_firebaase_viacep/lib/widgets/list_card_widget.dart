import 'package:cadastro_firebaase_viacep/screens/update_clients_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var snapshots = FirebaseFirestore.instance
        .collection("clientes")
        .where("email", isNotEqualTo: null)
        .snapshots();

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      elevation: 7,
      child: StreamBuilder(
        stream: snapshots,
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot,
        ) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data.docs.length == 0) {
            return Center(
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "Nenhum cliente cadastrado.",
                    style: TextStyle(fontSize: 20),
                  )),
            );
          }
          return Padding(
            padding: EdgeInsets.all(8),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int i) {
                var doc = snapshot.data.docs[i];
                var docId = doc.id;
                var item = doc.data();

                return GestureDetector(
                  onLongPress: () {
                    return showModalBottomSheet(
                        context: context,
                        builder: (_) {
                          return BottomSheet(
                            onClosing: () {},
                            builder: (_) => Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                FlatButton(
                                  padding: EdgeInsets.symmetric(vertical: 22),
                                  child: Text(
                                    'Alterar e-mail de cadastro',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                UpdateClientScreen(docId)));
                                  },
                                ),
                                FlatButton(
                                  padding: EdgeInsets.symmetric(vertical: 22),
                                  child: Text(
                                    'Excluir cadastro',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          title: Text(
                                            "Atenção:",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 22,
                                            ),
                                          ),
                                          content: Text(
                                            "Deseja confirmar a exclusão do cadastro desse usuário?",
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                          actions: [
                                            FlatButton(
                                              child: Text(
                                                "Cancelar",
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              },
                                            ),
                                            FlatButton(
                                              child: Text(
                                                "Continuar",
                                              ),
                                              onPressed: () async {
                                                await FirebaseFirestore.instance
                                                    .collection('clientes')
                                                    .doc(docId)
                                                    .delete();
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                )
                              ],
                            ),
                          );
                        });
                  },
                  child: ListTile(
                    title: Text(item['nome']),
                    subtitle: Text(
                      item['email'],
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
