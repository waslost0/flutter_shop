import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shop_flutter/src/categories/providers/category_provider.dart';
import 'package:shop_flutter/src/home/providers/products_data_provider.dart';

import 'app.dart';
import 'src/home/providers/product_detail_provider.dart';
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
  ChangeNotifierProvider<ProductsDataProvider>(
    create: (context) => ProductsDataProvider(),
  ),
  ChangeNotifierProvider<CategoryDataProvider>(
    create: (context) => CategoryDataProvider(),
  ),
  ChangeNotifierProvider<ProductDetailDataProvider>(
    create: (context) => ProductDetailDataProvider(),
  ),
  ChangeNotifierProvider<BottomNavigationBarProvider>(
    create: (context) => BottomNavigationBarProvider(),
    // builder: (context) => BottomNavigationBarProvider(),
  )
];
