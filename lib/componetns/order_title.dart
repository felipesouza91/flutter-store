import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({Key? key, required this.orderId}) : super(key: key);
  final String orderId;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection("orders")
              .doc(orderId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Código do perdido: ${snapshot.data!.id}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(_buildDescription(snapshot.data!.data()!)),
                SizedBox(height: 4),
                Text(
                  "Status do Pedido",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildCircle(
                        "1", "Em Analise", snapshot.data!.data()!["status"], 1),
                    Container(
                      height: 1,
                      width: 30,
                      color: Colors.grey,
                    ),
                    _buildCircle(
                        "2", "Preparando", snapshot.data!.data()!["status"], 2),
                    Container(
                      height: 1,
                      width: 30,
                      color: Colors.grey,
                    ),
                    _buildCircle(
                        "3", "Recebido", snapshot.data!.data()!["status"], 3),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }

  String _buildDescription(Map<String, dynamic> data) {
    String text = "Descrição:\n";
    for (var element in data["products"]) {
      text +=
          "${element["quantity"]} x ${element["productData"]["title"]} (R\$ ${element["productData"]["price"].toStringAsFixed(2)}) \n";
    }
    text += "Total: R\$ ${data["totalPrice"].toStringAsFixed(2)}";
    return text;
  }

  Widget _buildCircle(
      String title, String subtitle, int status, int thisStatus) {
    Color backColor = Colors.grey;
    Widget childer = Text(
      title,
      style: TextStyle(color: Colors.white),
    );

    if (status == thisStatus) {
      backColor = Colors.blue;
      childer = Stack(
        alignment: Alignment.center,
        children: [
          Text(title, style: TextStyle(color: Colors.white)),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white),
          )
        ],
      );
    }
    if (status > thisStatus) {
      backColor = Colors.green;
      childer = Icon(Icons.check);
    }

    return Column(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: backColor,
          child: childer,
        ),
        Text(subtitle)
      ],
    );
  }
}
