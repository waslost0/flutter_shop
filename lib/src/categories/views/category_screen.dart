import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/src/categories/models/category.dart';
import 'package:shop_flutter/src/categories/providers/category_provider.dart';
import 'package:shop_flutter/src/products/views/product_screen.dart';

class ProductGridScreen extends StatefulWidget {
  const ProductGridScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProductGridScreenState();
  }
}

class ProductGridScreenState extends State<ProductGridScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    var categoryDataProvider = context.read<CategoryDataProvider>();
    categoryDataProvider.getCategoriesData();
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

  Widget gestureDetector(BuildContext context, Category category) {
    return GestureDetector(
      onTap: () {
        //TODO: try check category.hasSubcategories. Open CategoryScreen with argument = parentCategory
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductListScreen(
              category: category,
            ),
          ),
        );
      },
      child: buildCard(
        context,
        category,
      ),
    );
  }

  Widget buildGridView(
    BuildContext context,
    CategoryDataProvider categoryDataProvider,
  ) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: categoryDataProvider.allCategories.length,
      itemBuilder: (BuildContext context, int index) {
        Category category = categoryDataProvider.allCategories[index];
        print(category.hasSubcategories);

        return gestureDetector(context, category);
      },
      scrollDirection: Axis.vertical,
    );
  }

  Widget buildBody(BuildContext context) {
    var categoryDataProvider = context.watch<CategoryDataProvider>();

    return Container(
      child: categoryDataProvider.loading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : buildGridView(
              context,
              categoryDataProvider,
            ),
    );
  }

  Widget buildCard(BuildContext context, Category category) {
    return Card(
      child: Column(
        children: [
          buildImage(context, category),
          buildCategoryTitle(context, category),
        ],
      ),
    );
  }

  Widget buildImage(BuildContext context, Category category) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: CachedNetworkImage(
          imageUrl: category.imageUrl ?? '',
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/img_not_found.jpg',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCategoryTitle(BuildContext context, Category category) {
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
