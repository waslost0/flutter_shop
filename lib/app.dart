import 'package:flutter/material.dart';
import 'package:shop_flutter/src/categories/views/category_screen.dart';
import 'package:shop_flutter/src/main_menu/views/main_menu.dart';

import 'src/home/views/home_screen.dart';
import 'src/product_detail/view/product_detail.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      home: MainMenu(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/category': (context) => CategoryScreen(),
        '/detail': (context) => ProductDetailPage(),
        // '/category': (context) => CategoryPage(),
      },
    );
  }
}
