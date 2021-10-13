import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_flutter/src/categories/models/category.dart';
import 'package:shop_flutter/src/products/models/product.dart';
import 'package:shop_flutter/src/products/providers/products_data_provider.dart';
import 'package:shop_flutter/src/products/views/product_detail.dart';
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
  final ProductsDataProvider dataProvider = ProductsDataProvider();

  @override
  void initState() {
    super.initState();
    dataProvider.addListener(onDataProviderChanged);
    loadData();
  }

  @override
  void dispose() {
    dataProvider.removeListener(onDataProviderChanged);
    super.dispose();
  }

  void onDataProviderChanged() {
    setState(() {});
  }

  Future<void> loadData() async {
    var category = widget.category;
    print('Category ${category?.categoryId}');
    dataProvider.getProductsData(
      categoryId: category?.categoryId,
    );
    // setState(() {});
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
      body: buildBody(context),
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

    return ListView.builder(
      itemCount: dataProvider.allProducts.length,
      itemBuilder: (BuildContext context, int index) {
        Product product = dataProvider.allProducts[index];
        print(product.imageUrl);
        return buildGestureDetector(context, product);
      },
      scrollDirection: Axis.vertical,
    );
  }

  void onListViewItemTap(BuildContext context, Product product) async {
    product.productDescription = "local description";
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductDetailPage(
          product: product,
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: dataProvider.loading
            ? buildPlaceholder(context)
            : buildListView(context),
      ),
    );
  }
}
