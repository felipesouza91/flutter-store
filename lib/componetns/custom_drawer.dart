import 'package:flutter/material.dart';
import 'package:store/componetns/drawer_tile.dart';
import 'package:store/screens/login_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key, required this.pageController})
      : super(key: key);

  final PageController pageController;

  Widget _buildDrawerBack() => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: const [Color.fromARGB(255, 203, 236, 241), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Stack(
      children: [
        _buildDrawerBack(),
        ListView(
          padding: EdgeInsets.only(left: 32, top: 16),
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 8),
              padding: EdgeInsets.fromLTRB(0, 16, 16, 8),
              height: 170,
              child: Stack(
                children: [
                  Positioned(
                    top: 8,
                    left: 0,
                    child: Text(
                      "Flutter´s\nClothing",
                      style:
                          TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ola,",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LoginScreem()));
                          },
                          child: Text(
                            "Entre ou cadastre-se >",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider(),
            DrawerTile(
              title: "Inicio",
              icon: Icons.home,
              pageController: pageController,
              page: 0,
            ),
            DrawerTile(
              title: "Produtos",
              icon: Icons.list,
              pageController: pageController,
              page: 1,
            ),
            DrawerTile(
              title: "Lojas",
              icon: Icons.location_on,
              pageController: pageController,
              page: 2,
            ),
            DrawerTile(
              title: "Meus Pedidos",
              icon: Icons.playlist_add_check,
              pageController: pageController,
              page: 3,
            ),
          ],
        )
      ],
    ));
  }
}
