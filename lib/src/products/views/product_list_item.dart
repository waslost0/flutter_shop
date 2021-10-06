import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_flutter/src/products/models/product.dart';

class ProductListItem extends StatelessWidget {
  final Product product;

  const ProductListItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          buildProductImage(context, product),
          buildProductTitle(context, product),
          buildProductPrice(context, product),
        ],
      ),
    );
  }

  Widget buildProductImage(BuildContext context, Product product) {
    return CachedNetworkImage(
      imageUrl: product.imageUrl ?? '',
      height: 150,
      fit: BoxFit.fitHeight,
      errorWidget: (context, url, error) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/img_not_found.jpg'),
          ),
        ),
      ),
    );
  }

  Widget buildProductPrice(BuildContext context, Product product) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        '${product.price.toString()} ₽',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget buildProductTitle(BuildContext context, Product product) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
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
}
