import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/src/products/models/product.dart';
import 'package:shop_flutter/src/products/providers/product_detail_provider.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProductDetailPageState();
  }
}

class ProductDetailPageState extends State<ProductDetailPage> {
  @override
  void initState() {
    super.initState();
    // loadData();
  }

  Future<void> loadData() async {
    var productDetailProvider = context.read<ProductDetailDataProvider>();
    // productDetailProvider.getCurrentProductData();
    setState(() {});
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

  Widget buildProductImage(Product product) {
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

  Widget buildProductTitle(Product product) {
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

  Widget buildProductDescription(productDescription) {
    return Padding(
      padding: EdgeInsets.only(top: 0, left: 15, right: 15, bottom: 10),
      child: Text(productDescription.toString()),
    );
  }

  Widget buildProductPrice(productPrice) {
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

  Widget buildProductDetail() {
    var product = ModalRoute.of(context)!.settings.arguments as Product;
    print(product.title);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildProductImage(product),
        buildProductTitle(product),
        if (product.productDescription != null)
          buildProductDescription(product.productDescription),
        buildProductPrice(product.price)
      ],
    );
  }

  Widget buildBody(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Card(
          elevation: 10,
          child: buildProductDetail(),
        ),
      ),
    );
  }
}
