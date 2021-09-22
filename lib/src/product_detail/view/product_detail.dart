import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/src/categories/providers/category_provider.dart';
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
    loadData();
  }

  Future<void> loadData() async {
    var productDetailProvider = context.read<ProductDetailDataProvider>();
    productDetailProvider.getCurrentProductData(productDetailProvider.product.productId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var categoryDataProvider = context.watch<CategoryDataProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Товар"),
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    var productDetailProvider = context.watch<ProductDetailDataProvider>();

    return Container(
      child: productDetailProvider.loading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(2.0),
              child: Card(
                elevation: 10,
                child: Column(
                  children: [
                    CachedNetworkImage(
                      // alignment: Alignment.topLeft,
                      imageUrl: productDetailProvider.product.imageUrl == null
                          ? ''
                          : productDetailProvider.product.imageUrl!,
                      height: MediaQuery.of(context).size.height / 4,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fitHeight,
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image:
                                AssetImage('assets/images/img_not_found.jpg'),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        productDetailProvider.product.title.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (productDetailProvider.product.productDescription != null)
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 0, left: 15, right: 15, bottom: 10),
                        child: Text(productDetailProvider.product.productDescription.toString()),
                      ),
                    Text(
                      '${productDetailProvider.product.price.toString()} ₽',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
