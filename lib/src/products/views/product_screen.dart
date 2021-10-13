import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/src/categories/models/category.dart';
import 'package:shop_flutter/src/products/models/product.dart';
import 'package:shop_flutter/src/products/providers/products_data_provider.dart';
import 'package:shop_flutter/src/products/views/product_list_item.dart';

class ProductListScreen extends StatefulWidget {
  final Category? category;

  const ProductListScreen({
    Key? key,
    this.category,
  }) : super(key: key);

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  //TODO: add own ProductsDataProvider

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    var category = widget.category;
    var productProvider = context.read<ProductsDataProvider>();
    print('Category ${category?.categoryId}');
    productProvider.getProductsData(
      categoryId: category?.categoryId,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Shop'.toUpperCase(),
          ),
        ),
      ),
      body: _buildBody(context),
    );
  }

  Widget buildCard(BuildContext context, Product product) {
    return ProductListItem(product: product);
  }

  Widget buildPlaceholder(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget buildGestureDetector(BuildContext context, Product product) {
    return GestureDetector(
      onTap: () {
        onListViewItemTap(
          context,
          product,
        );
      },
      child: buildCard(
        context,
        product,
      ),
    );
  }

  Widget buildListView(BuildContext context) {
    var productProvider = context.read<ProductsDataProvider>();

    return ListView.builder(
      itemCount: productProvider.allProducts.length,
      itemBuilder: (BuildContext context, int index) {
        Product product = productProvider.allProducts[index];
        print(product.imageUrl);
        return buildGestureDetector(context, product);
      },
      scrollDirection: Axis.vertical,
    );
  }

  void onListViewItemTap(BuildContext context, Product product) async {
    Navigator.pushNamed(
      context,
      '/detail',
      arguments: product,
    );
  }

  Widget _buildBody(BuildContext context) {
    var productProvider = context.watch<ProductsDataProvider>();
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: productProvider.loading
            ? buildPlaceholder(context)
            : buildListView(context),
      ),
    );
  }
}
