import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/src/categories/models/category.dart';
import 'package:shop_flutter/src/categories/providers/category_provider.dart';
import 'package:shop_flutter/src/home/providers/product_detail_provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CategoryScreenState();
  }
}

class CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    var cart = context.read<CategoryDataProvider>();
    cart.getCategoriesData(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'categories'.toUpperCase(),
          ),
        ),
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    var cart = context.watch<CategoryDataProvider>();

    return Container(
      child: cart.loading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                Category category = cart.allCategories[index];

                return GestureDetector(
                  onTap: () {
                    var cart = context.read<CategoryDataProvider>();
                    cart.categoryId = category.categoryId!;
                    Navigator.pushNamed(
                      context,
                      '/home',
                    );
                  },
                  child: buildProductCard(context, category),
                );
              },
              scrollDirection: Axis.vertical,
            ),
    );


  }


  Widget buildProductCard(BuildContext context, product) {
    return Card(
      child: Column(
        children: [
          // CachedNetworkImage(
          //   imageUrl: product.imageUrl,
          //   height: MediaQuery.of(context).size.height / 4,
          //   width: MediaQuery.of(context).size.width,
          //   fit: BoxFit.fitHeight,
          //   // placeholder: (context, url) =>
          //   //     Center(child: CircularProgressIndicator()),
          //   errorWidget: (context, url, error) => Container(
          //     decoration: BoxDecoration(
          //       image: DecorationImage(
          //         image: AssetImage('assets/images/img_not_found.jpg'),
          //       ),
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              product.title.toString(),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
