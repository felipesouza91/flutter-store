import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.pageController,
    required this.page,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final PageController pageController;
  final int page;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          pageController.jumpToPage(page);
        },
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              Icon(
                icon,
                size: 32,
                color: pageController.page?.round() == page
                    ? Theme.of(context).primaryColor
                    : Colors.grey[700],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 10, 0, 10),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: pageController.page == page
                        ? Theme.of(context).primaryColor
                        : Colors.grey[700],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
