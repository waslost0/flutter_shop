import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_flutter/src/products/models/product.dart';
import 'package:shop_flutter/src/products/providers/product_detail_provider.dart';
import 'package:shop_flutter/src/products/widgets/product_detail_item.dart';

class ProductDetailPage extends StatefulWidget {
  final Product? product;

  const ProductDetailPage({
    Key? key,
    this.product,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProductDetailPageState();
  }
}

class ProductDetailPageState extends State<ProductDetailPage> {
  final ProductDetailDataProvider dataProvider = ProductDetailDataProvider();

  @override
  void initState() {
    super.initState();
    dataProvider.addListener((onDataProviderChanged));
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
    var product = widget.product;
    dataProvider.getCurrentProductData(product!.productId!);
    print('loadData Product ${product.productId}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Товар"),
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    var product = widget.product!;

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Card(
          elevation: 10,
          child: dataProvider.loading
              ? ProductDetailItem(product: product)
              : ProductDetailItem(product: dataProvider.product!),
        ),
      ),
    );
  }
}

