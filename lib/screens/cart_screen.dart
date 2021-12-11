import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:store/componetns/cart_product_tile.dart';
import 'package:store/componetns/cart_resume.dart';
import 'package:store/componetns/discount_cart.dart';
import 'package:store/componetns/required_login.dart';
import 'package:store/componetns/ship_card.dart';
import 'package:store/models/cart_model.dart';
import 'package:store/screens/order_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu carrinho"),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        actions: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 8),
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
                return Text(
                    "${model.products.length} ${model.products.length == 1 ? "Item" : "Itens"}");
              },
            ),
          )
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) {
          if (model.isLoading && model.user.isLoggedIn()) {
            return Center(child: CircularProgressIndicator());
          } else if (!model.user.isLoggedIn()) {
            return RequiredLogin(
              description: "Faça o login para adicionar produtos",
              icon: Icons.remove_shopping_cart,
            );
          } else if (model.products == null || model.products.isEmpty) {
            return Center(
              child: Text(
                "Nenhum produto no carrinho!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return ListView(
              children: [
                Column(
                  children: model.products
                      .map((item) => CartProductTile(
                            cartProduct: item,
                          ))
                      .toList(),
                ),
                DiscountCart(),
                ShippingCard(),
                CartResume(
                  buy: () async {
                    print("Arqui");
                    String? orderId = await model.finishOrder();
                    print(orderId);
                    if (orderId != null) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => OrderScreen(orderId: orderId),
                        ),
                      );
                    }
                  },
                )
              ],
            );
          }
        },
      ),
    );
  }
}
