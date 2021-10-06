import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/src/categories/models/category.dart';
import 'package:shop_flutter/src/categories/providers/category_provider.dart';
import 'package:shop_flutter/src/products/models/product.dart';
import 'package:shop_flutter/src/products/providers/product_detail_provider.dart';
import 'package:shop_flutter/src/products/providers/products_data_provider.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/src/products/views/product_detail.dart';
import 'package:shop_flutter/src/products/views/product_list_item.dart';

class ProductScreen extends StatefulWidget {
  final Category? category;

  const ProductScreen({
    Key? key,
    this.category,
  }) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState(category);
}

class _ProductScreenState extends State<ProductScreen> {
  final Category? category;

  _ProductScreenState(this.category);

  //TODO: add own ProductsDataProvider

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    var productProvider = context.read<ProductsDataProvider>();
    print(this.category);
    if (this.category != null) {
      print('Category ${this.category?.categoryId}');
      productProvider.getProductsData(categoryId: this.category!.categoryId);
    } else if (this.category == null) {
      productProvider.getProductsData();
    }
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
      // body: _buildBody(context),
    );
  }

  Widget buildProductCard(BuildContext context, product) {
    return ProductListItem(product: product);
  }

  Widget buildPlaceholder() {
    return Container(
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget buildListView() {
    var productProvider = context.read<ProductsDataProvider>();

    return ListView.builder(
      itemCount: productProvider.allProducts.length,
      itemBuilder: (BuildContext context, int index) {
        Product product = productProvider.allProducts[index];

        print(product.imageUrl);
        return GestureDetector(
          onTap: () {
            onListViewItemTap(context, product);
          },
          child: buildProductCard(context, product),
        );
      },
      scrollDirection: Axis.vertical,
    );
  }

  void onListViewItemTap(BuildContext context,Product product) async {
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => ProductDetailPage(product: product),
    //
    //   ),
    // );

    Navigator.pushNamed(context, '/detail', arguments: product);
  }

  Widget _buildBody(BuildContext context) {
    var productProvider = context.watch<ProductsDataProvider>();
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: productProvider.loading ? buildPlaceholder() : buildListView(),
      ),
    );
  }
}
