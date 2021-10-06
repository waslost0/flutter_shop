import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/src/categories/models/category.dart';
import 'package:shop_flutter/src/categories/providers/category_provider.dart';
import 'package:shop_flutter/src/products/models/product.dart';
import 'package:shop_flutter/src/products/views/product_screen.dart';

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
    var categoryDataProvider = context.read<CategoryDataProvider>();
    categoryDataProvider.getCategoriesData(context);
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
    var categoryDataProvider = context.watch<CategoryDataProvider>();

    return Container(
      child: categoryDataProvider.loading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: categoryDataProvider.allCategories.length,
              itemBuilder: (BuildContext context, int index) {
                Category category = categoryDataProvider.allCategories[index];

                return GestureDetector(
                  onTap: () {
                    //TODO: try check category.hasSubcategories. Open CategoryScreen with argument = parentCategory
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductScreen(category: category),
                      ),
                    );

                    // Navigator.pushNamed(
                    //   context,
                    //   '/products',
                    //   arguments: category,
                    //
                    //   //TODO: add category to args: https://flutter.dev/docs/cookbook/navigation/navigate-with-arguments
                    // );
                  },
                  child: buildCategoryCard(context, category),
                );
              },
              scrollDirection: Axis.vertical,
            ),
    );
  }

  Widget buildCategoryCard(BuildContext context, category) {
    return Card(
      child: Column(
        children: [
          buildCategoryImage(category),
          buildCategoryTitle(category),
        ],
      ),
    );
  }

  Widget buildCategoryImage(category) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: CachedNetworkImage(
          imageUrl: category.imageUrl,
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
    );
  }

  Widget buildCategoryTitle(category) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(
          category.title.toString(),
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 15,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
