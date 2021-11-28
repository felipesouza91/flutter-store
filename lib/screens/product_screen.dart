import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:store/datas/product.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  _ProductScreenState(this.product);
  final Product product;

  @override
  Widget build(BuildContext context) {
    final primariColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        backgroundColor: primariColor,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          CarouselSlider(
            items: product.images
                .map(
                  (e) => AspectRatio(
                    aspectRatio: 0.9,
                    child: Image.network(
                      e,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
                .toList(),
            options: CarouselOptions(
                viewportFraction: 1,
                aspectRatio: 0.9,
                autoPlay: false,
                enlargeStrategy: CenterPageEnlargeStrategy.scale),
          ),
        ],
      ),
    );
  }
}
