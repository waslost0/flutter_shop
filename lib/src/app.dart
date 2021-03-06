import 'package:flutter/material.dart';
import 'package:shop_flutter/src/categories/views/category_screen.dart';
import 'package:shop_flutter/src/main_menu/views/main_menu.dart';

import 'products/views/product_screen.dart';
import 'products/views/product_detail.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      home: MainMenu(),
      routes: {
        '/products': (context) => ProductListScreen(),
        '/category': (context) => CategoryGridScreen(),
        '/detail': (context) => ProductDetailPage(),
      },
    );
  }
}
