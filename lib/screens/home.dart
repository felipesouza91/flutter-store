import 'package:flutter/material.dart';
import 'package:store/componetns/cart_button.dart';
import 'package:store/componetns/custom_drawer.dart';
import 'package:store/screens/tab/orders_tab.dart';
import 'package:store/screens/tab/product_tab.dart';
import 'package:store/screens/tab/home_tab.dart';
import 'package:store/screens/tab/store_tab.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Scaffold(
          drawer: CustomDrawer(pageController: _pageController),
          body: HomeTab(),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          drawer: CustomDrawer(pageController: _pageController),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Theme.of(context).primaryColor,
            title: Text("Produtos"),
          ),
          body: ProductTab(),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          drawer: CustomDrawer(pageController: _pageController),
          appBar: AppBar(
            title: Text("Lojas"),
            centerTitle: true,
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: StoresTab(),
        ),
        Scaffold(
          drawer: CustomDrawer(pageController: _pageController),
          appBar: AppBar(
            title: Text("Meus Pedidos"),
            centerTitle: true,
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: OrdersTab(),
        )
      ],
    );
  }
}
