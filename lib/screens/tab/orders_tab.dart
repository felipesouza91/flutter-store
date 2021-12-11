import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:store/componetns/order_title.dart';
import 'package:store/componetns/required_login.dart';
import 'package:store/models/user_model.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (UserModel.of(context).isLoggedIn()) {
      var uid = UserModel.of(context).firebaseUser!.uid;
      return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .collection("orders")
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: snapshot.data!.docs
                  .map((order) => OrderTile(orderId: order.id))
                  .toList(),
            );
          }
        },
      );
    } else {
      return RequiredLogin(
        description: "Faça o login para acompanhar!",
        icon: Icons.list,
      );
    }
  }
}
