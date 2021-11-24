import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);
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
                children: const [
                  Positioned(
                    child: Text(
                      "Flutter´s\nClothing",
                      style:
                          TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                    ),
                    top: 8,
                    left: 0,
                  )
                ],
              ),
            )
          ],
        )
      ],
    ));
  }
}
