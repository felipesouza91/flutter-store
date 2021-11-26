import 'package:flutter/material.dart';
import 'package:store/componetns/category_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductTab extends StatelessWidget {
  const ProductTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: FirebaseFirestore.instance.collection("products").get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          var divededTiles = ListTile.divideTiles(
                  tiles: snapshot.data!.docs
                      .map((document) => CategoryTile(snapshot: document))
                      .toList(),
                  color: Colors.grey[500])
              .toList();
          return ListView(
            children: divededTiles,
          );
        }
      },
    );
  }
}
