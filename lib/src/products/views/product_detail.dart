import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_flutter/src/products/models/product.dart';
import 'package:shop_flutter/src/products/providers/product_detail_provider.dart';

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
        title: Text("Товар"),
      ),
      body: buildBody(context),
    );
  }

  Widget buildProductImage(BuildContext context, Product product) {
    return CachedNetworkImage(
      imageUrl: product.imageUrl ?? '',
      height: 150,
      // width: 200,
      fit: BoxFit.fitHeight,
      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/img_not_found.jpg'),
          ),
        ),
      ),
    );
  }

  Widget buildProductTitle(BuildContext context, Product product) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        product.title.toString(),
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget buildProductDescription(BuildContext context, productDescription) {
    return Padding(
      padding: EdgeInsets.only(top: 0, left: 15, right: 15, bottom: 10),
      child: Text(productDescription.toString()),
    );
  }

  Widget buildProductPrice(BuildContext context, productPrice) {
    return Center(
      child: Text(
        '${productPrice.toString()} ₽',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget buildProductDetail(BuildContext context, Product product) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (product.imageUrl != null)
          buildProductImage(context, product),
        if (product.title != null)
          buildProductTitle(context, product),
        if (product.productDescription != null)
          buildProductDescription(context, product.productDescription),
        if (product.productDescription != null)
          buildProductPrice(context, product.price)
      ],
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
              ? buildProductDetail(context, product)
              : buildProductDetail(context, dataProvider.product!),
        ),
      ),
    );
  }
}

