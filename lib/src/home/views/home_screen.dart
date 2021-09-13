import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/src/categories/providers/category_provider.dart';
import 'package:shop_flutter/src/home/providers/product_detail_provider.dart';
import 'package:shop_flutter/src/models/product.dart';
import 'package:shop_flutter/src/home/providers/products_data_provider.dart';
import 'package:shop_flutter/src/product_detail/view/product_detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    var productsProvider = context.read<ProductsDataProvider>();
    var categoryProvider = context.read<CategoryDataProvider>();
    if (categoryProvider.isProductsByCategory) {
      productsProvider.getProductsData(context);
    } else {
      productsProvider.getProductsOfCategory(context, categoryProvider.categoryId);
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
    return Card(
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: product.images!.length == 0 ? '' : product.images![0],
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fitHeight,
            errorWidget: (context, url, error) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/img_not_found.jpg'),
                ),
              ),
            ),
          ),
          Padding(
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
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              '${product.price.toString()} ₽',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    var productMdl = context.watch<ProductsDataProvider>();


    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: productMdl.loading
            ? Container(
                child: Center(child: CircularProgressIndicator()),
              )
            : ListView.builder(
                itemCount: productMdl.allProducts.length,
                itemBuilder: (BuildContext context, int index) {
                  Product product = productMdl.allProducts[index];

                  print(product.productId);
                  return GestureDetector(
                    onTap: () {
                      var cart = context.read<ProductDetailDataProvider>();
                      cart.productId = product.productId!;
                      Navigator.pushNamed(
                        context,
                        '/detail',
                      );
                    },
                    child: buildProductCard(context, product),
                  );
                },
                scrollDirection: Axis.vertical,
              ),
      ),
    );
  }
}
