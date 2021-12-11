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
    products = firbaseProducts.docs.map((e) {
      return CartProduct.fromDocument(e);
    }).toList();
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
    cartProduct.quantity++;
    FirebaseFirestore.instance
        .collection("users")
        .doc(user.firebaseUser!.uid)
        .collection("cart")
        .doc(cartProduct.id)
        .update(cartProduct.toMap());
    notifyListeners();
  }

  void updatePrice() {
    notifyListeners();
  }

  Future<String?> finishOrder() async {
    if (products.isEmpty) return null;
    isLoading = true;
    notifyListeners();
    double productPrice = getProductsPrice();
    double shipPrice = getShipPrice();
    double discount = getDiscount();
    DocumentReference<Map<String, dynamic>> order =
        await FirebaseFirestore.instance.collection("orders").add({
      "clientId": user.firebaseUser!.uid,
      "products": products.map((product) => product.toMap()).toList(),
      "shipPrice": shipPrice,
      "productsPrice": productPrice,
      "discount": discount,
      "totalPrice": productPrice - discount + shipPrice,
      "status": 1
    });
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user.firebaseUser!.uid)
        .collection("orders")
        .doc(order.id)
        .set({"orderId": order.id});

    QuerySnapshot query = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.firebaseUser!.uid)
        .collection("cart")
        .get();
    for (var e in query.docs) {
      e.reference.delete();
    }
    products.clear();
    discountPercenage = 0;
    couponCode = null;
    isLoading = false;
    notifyListeners();
    return order.id;
  }

  double getProductsPrice() {
    return products.fold<double>(0.0, (previousValue, element) {
      if (element.productData != null) {
        return previousValue + (element.productData!.price * element.quantity);
      } else {
        return 0;
      }
    });
  }

  double getShipPrice() {
    return 9.99;
  }

  double getDiscount() {
    return getProductsPrice() * discountPercenage / 100;
  }
}
