import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store/datas/product.dart';

class CartProduct {
  String? id;
  String category;
  String productId;
  int quantity;
  String size;
  Product? productData;

  CartProduct(this.category, this.productData, this.productId, this.quantity,
      this.size);

  CartProduct.fromDocument(DocumentSnapshot<Map<String, dynamic>> document)
      : id = document.id,
        category = document.data()!['category'],
        productId = document.data()!['productId'],
        quantity = document.data()!["quantity"],
        size = document.data()!["size"];

  Map<String, dynamic> toMap() {
    return {
      "category": category,
      "productId": productId,
      "quantity": quantity,
      "size": size,
      //"productData": productData.toResumeMap()
    };
  }
}
