import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreTile extends StatelessWidget {
  const StoreTile({Key? key, required this.data}) : super(key: key);
  final DocumentSnapshot<Map<String, dynamic>> data;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 150,
            child: Image.network(
              data.data()!["imageUrl"],
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          SizedBox(height: 12),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.data()!["title"],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                SizedBox(height: 4),
                Text(
                  data.data()!["address"],
                  style: TextStyle(fontSize: 15),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    launch(
                        "https://www.google.com/maps/search/?api=1&query=${data.data()!["lat"]},${data.data()!["long"]}");
                  },
                  child: Text("Ver no mapa")),
              TextButton(
                  onPressed: () {
                    launch("tel:${data.data()!["phone"]}");
                  },
                  child: Text("Ligar")),
            ],
          )
        ],
      ),
    );
  }
}
