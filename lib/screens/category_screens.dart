import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:store/componetns/product_tile.dart';
import 'package:store/datas/product.dart';

class CategoryScreem extends StatelessWidget {
  const CategoryScreem({Key? key, required this.snapshot}) : super(key: key);
  final DocumentSnapshot<Map<String, dynamic>> snapshot;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(snapshot.data()!['title']),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: const [
              Tab(
                icon: Icon(Icons.grid_on),
              ),
              Tab(
                icon: Icon(Icons.list),
              )
            ],
          ),
        ),
        body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection("products")
              .doc(snapshot.id)
              .collection('itens')
              .get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return TabBarView(
                children: [
                  GridView.builder(
                    padding: EdgeInsets.all(4),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      childAspectRatio: 0.65,
                    ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return ProductTile(
                          type: "grid",
                          product:
                              Product.fromDocument(snapshot.data!.docs[index]));
                    },
                  ),
                  ListView.builder(
                    padding: EdgeInsets.all(4),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return ProductTile(
                          type: "list",
                          product:
                              Product.fromDocument(snapshot.data!.docs[index]));
                    },
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
