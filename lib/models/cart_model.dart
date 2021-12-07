import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:store/datas/cart_product.dart';
import 'package:store/models/user_model.dart';

class CartModel extends Model {
  UserModel user;
  List<CartProduct> products = [];
  String? couponCode;
  int discountPercenage = 0;
  bool isLoading = false;
  CartModel(this.user) {
    if (user.isLoggedIn()) {
      _loadCurrentUser();
    }
  }

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  void _loadCurrentUser() async {
    var firbaseProducts = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.firebaseUser!.uid)
        .collection("cart")
        .get();
    products =
        firbaseProducts.docs.map((e) => CartProduct.fromDocument(e)).toList();
    notifyListeners();
  }

  void addCartItem(CartProduct product) {
    products.add(product);
    FirebaseFirestore.instance
        .collection("users")
        .doc(user.firebaseUser!.uid)
        .collection("cart")
        .add(product.toMap())
        .then((document) {
      product.id = document.id;
    });
    notifyListeners();
  }

  void removeCartItem(CartProduct product) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user.firebaseUser!.uid)
        .collection("cart")
        .doc(product.id)
        .delete();
    products.remove(product);
    notifyListeners();
  }

  void setCouponCode(String text, int discountPercenage) {
    couponCode = text;
    this.discountPercenage = discountPercenage;
    notifyListeners();
  }

  void decProduct(CartProduct cartProduct) {
    cartProduct.quantity--;
    FirebaseFirestore.instance
        .collection("users")
        .doc(user.firebaseUser!.uid)
        .collection("cart")
        .doc(cartProduct.id)
        .update(cartProduct.toMap());
    notifyListeners();
  }

  void incProduct(CartProduct cartProduct) {
    print(cartProduct.id);
    cartProduct.quantity++;
    FirebaseFirestore.instance
        .collection("users")
        .doc(user.firebaseUser!.uid)
        .collection("cart")
        .doc(cartProduct.id)
        .update(cartProduct.toMap());
    notifyListeners();
  }
}
