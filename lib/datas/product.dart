import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String id;
  String title;
  String description;
  double price;
  List<String> sizes;
  List<String> images;
  String? category;

  Product.fromDocument(DocumentSnapshot<Map<String, dynamic>> document)
      : id = document.id,
        title = document.data()!['title'],
        description = document.data()!['description'],
        price = document.data()!['price'],
        sizes = document.data()!['sizes'].cast<String>(),
        images = document.data()!['images'].cast<String>();

  Map<String, dynamic> toResumeMap() {
    return {
      "title": title,
      "price": price,
    };
  }
}
