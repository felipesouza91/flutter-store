import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            Container(
              color: Colors.red,
            ),
            Container(
              color: Colors.green,
            )
          ],
        ),
      ),
    );
  }
}
