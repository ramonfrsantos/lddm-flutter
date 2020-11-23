import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _buildBodyBack() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  List: [Color(0xFFFFE787), Color(0xFFEBF8B8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
        );

    return Stack(
      children: <Widget>[
        _buildBodyBack(),
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Novidades",
                    style: TextStyle(color: Color(0xFF323031))),
                centerTitle: true,
              ),
            ),
            FutureBuilder<QuerySnapshot>(
                future: Firestore.instance
                    .collection("https://loja-virtual-ab0ae.firebaseio.com/")
                    .orderBy("pos")
                    .getDocuments(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return SliverToBoxAdapter(
                      child: Container(
                        height: 200,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xFF323031)),
                        ),
                      ),
                    );
                  } else {
                    return SliverStaggeredGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 1.0,
                      crossAxisSpacing: 1.0,
                      staggeredTiles: snapshot.data.documents.map((doc) {
                        return StaggeredTile.count(
                            doc.data["x"], doc.data["y"]);
                      }).toList(),
                      children: snapshot.data.documents.map((doc) {
                        return FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: doc.data["image"],
                          fit: BoxFit.cover,
                        );
                      }).toList(),
                    );
                  }
                })
          ],
        )
      ],
    );
  }
}
