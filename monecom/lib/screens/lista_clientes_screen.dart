import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListaClientesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var snapshots = FirebaseFirestore.instance
        .collection("clientes")
        .where("email", isNotEqualTo: null)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Lista de clientes cadastrados",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: 350,
            height: 700,
            child: Card(
              elevation: 4,
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
                      child: Text("Nenhuma tarefa ainda!"),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int i) {
                      var item = snapshot.data.docs[i].data();

                      return GestureDetector(
                        onTap: () {},
                        child: ListTile(
                          title: Text(item['nome']),
                          subtitle: Text(
                            item['email'],
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
