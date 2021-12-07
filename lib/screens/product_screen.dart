import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:store/componetns/cart_button.dart';
import 'package:store/datas/cart_product.dart';
import 'package:store/datas/product.dart';
import 'package:store/models/cart_model.dart';
import 'package:store/models/user_model.dart';
import 'package:store/screens/login_screen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  _ProductScreenState(this.product);
  final Product product;
  int _current = 0;
  final CarouselController _controller = CarouselController();

  String? _size;

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
          Stack(
            alignment: Alignment.bottomCenter,
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
                    enlargeStrategy: CenterPageEnlargeStrategy.scale,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: product.images.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black)
                              .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  product.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: primariColor,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Tamanho",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 34,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.5,
                    ),
                    children: product.sizes
                        .map(
                          (size) => GestureDetector(
                            child: Container(
                              width: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                                border: Border.all(
                                  width: 3,
                                  color: size == _size
                                      ? primariColor
                                      : Colors.grey,
                                ),
                              ),
                              child: Text(
                                size,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                _size = size;
                              });
                            },
                          ),
                        )
                        .toList(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 16, 0, 16),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          _size != null || !UserModel.of(context).isLoggedIn()
                              ? primariColor
                              : Colors.grey),
                      fixedSize: MaterialStateProperty.all(
                        Size.fromHeight(50),
                      ),
                    ),
                    onPressed: () {
                      if (UserModel.of(context).isLoggedIn()) {
                        if (_size != null) {
                          var cartProduct = CartProduct(product.category!,
                              product, product.id, 1, _size!);
                          CartModel.of(context).addCartItem(cartProduct);
                        } else {
                          null;
                        }
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                      }
                    },
                    child: Text(
                      UserModel.of(context).isLoggedIn()
                          ? "Adicionar ao Carrinho"
                          : "Entrar para comprar",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Text(
                  "Descrição",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  product.description,
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
