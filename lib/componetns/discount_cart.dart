import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:store/models/cart_model.dart';

class DiscountCart extends StatelessWidget {
  const DiscountCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        title: Text(
          "Cupom de desconto",
          textAlign: TextAlign.start,
          style:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[700]),
        ),
        leading: Icon(Icons.card_giftcard),
        trailing: Icon(Icons.add),
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextFormField(
              onFieldSubmitted: (text) async {
                var coupon = await FirebaseFirestore.instance
                    .collection("coupons")
                    .doc(text)
                    .get();
                if (coupon.data() != null) {
                  CartModel.of(context)
                      .setCouponCode(text, coupon.data()!['percent']);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Theme.of(context).primaryColor,
                      content: Text(
                          "Desconto de ${coupon.data()!['percent']}% aplicado!")));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Cupom não e valido"),
                    backgroundColor: Colors.red,
                  ));
                }
              },
              initialValue: CartModel.of(context).couponCode ?? "",
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Digite seu cupom"),
            ),
          )
        ],
      ),
    );
  }
}
