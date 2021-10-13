import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shop_flutter/src/categories/providers/category_provider.dart';
import 'package:shop_flutter/src/products/providers/product_detail_provider.dart';
import 'package:shop_flutter/src/products/providers/products_data_provider.dart';
import 'src/app.dart';
import 'src/main_menu/providers/bottom_navigation_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: providers,
      child: App(),
    ),
  );
}

List<SingleChildWidget> providers = [
  //TODO: remove, make not global. Create on product detail screen
  ChangeNotifierProvider<CategoryDataProvider>(
    create: (context) => CategoryDataProvider(),
  ),
  //TODO: remove

  ChangeNotifierProvider<BottomNavigationBarProvider>(
    create: (context) => BottomNavigationBarProvider(),
    // builder: (context) => BottomNavigationBarProvider(),
  )
];
