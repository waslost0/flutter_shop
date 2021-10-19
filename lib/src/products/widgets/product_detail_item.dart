import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_flutter/src/products/models/product.dart';

class ProductDetailItem extends StatelessWidget {
  final Product product;

  const ProductDetailItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (product.imageUrl != null) buildImage(context, product),
          if (product.title != null) buildTitle(context, product),
          if (product.productDescription != null)
            buildDescription(context, product.productDescription),
          if (product.price != null) buildPrice(context, product.price)
        ],
      ),
    );
  }

  Widget buildDescription(BuildContext context, productDescription) {
    return Padding(
      padding: EdgeInsets.only(top: 0, left: 15, right: 15, bottom: 10),
      child: Text(
        productDescription.toString(),
      ),
    );
  }

  Widget buildImage(BuildContext context, Product product) {
    return CachedNetworkImage(
      imageUrl: product.imageUrl ?? '',
      height: 150,
      fit: BoxFit.fitHeight,
      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/img_not_found.jpg',
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPrice(BuildContext context, productPrice) {
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

  Widget buildTitle(BuildContext context, Product product) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        product.title.toString(),
        textAlign: TextAlign.center,
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
