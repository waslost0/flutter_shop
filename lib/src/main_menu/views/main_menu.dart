import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/src/main_menu/providers/bottom_navigation_provider.dart';

import '../../categories/views/category_screen.dart';
import '../../products/views/product_screen.dart';

class MainMenu extends StatefulWidget {
  MainMenu({
    Key? key,
  }) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  var currentTab = [
    ProductListScreen(),
    ProductGridScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomNavigationBar =
        Provider.of<BottomNavigationBarProvider>(context);

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomNavigationBar.currentIndex,
        onTap: (index) {
          bottomNavigationBar.currentIndex = index;
        },
        selectedItemColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            activeIcon: new Icon(Icons.home),
            label: 'Home',
            icon: new Icon(Icons.home_outlined),
          ),
          BottomNavigationBarItem(
            activeIcon: new Icon(Icons.category),
            label: 'Category',
            icon: new Icon(Icons.category_outlined),
          ),
        ],
      ),
      body: currentTab[bottomNavigationBar.currentIndex],
    );
  }
}
