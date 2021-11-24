import 'package:flutter/material.dart';
import 'package:store/componetns/custom_drawer.dart';
import 'package:store/screens/tab/home_tab.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: const [
        Scaffold(
          drawer: CustomDrawer(),
          body: HomeTab(),
        )
      ],
    );
  }
}
