import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:store/screens/category_screens.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({Key? key, required this.snapshot}) : super(key: key);

  final DocumentSnapshot<Map<String, dynamic>> snapshot;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(snapshot.data()!["icon"]),
      ),
      title: Text(snapshot.data()!["title"]),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CategoryScreem(
                  snapshot: snapshot,
                )));
      },
    );
  }
}
