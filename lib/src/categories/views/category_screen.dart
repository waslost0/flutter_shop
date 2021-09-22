import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/src/categories/models/category.dart';
import 'package:shop_flutter/src/categories/providers/category_provider.dart';

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
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  // childAspectRatio: 3 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemCount: cart.allCategories.length,
              itemBuilder: (BuildContext context, int index) {
                Category category = cart.allCategories[index];

                return GestureDetector(
                  onTap: () {
                    cart.categoryId = category.categoryId!;
                    cart.isProductsByCategory = true;
                    cart.currentCategory = category.title.toString();
                    Navigator.pushNamed(
                      context,
                      '/products',
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
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: CachedNetworkImage(
                imageUrl: product.imageUrl,
                height: MediaQuery.of(context).size.height / 10,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.scaleDown,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/img_not_found.jpg'),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                product.title.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
