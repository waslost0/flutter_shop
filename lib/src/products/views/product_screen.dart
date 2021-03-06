import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_flutter/src/categories/models/category.dart';
import 'package:shop_flutter/src/products/models/product.dart';
import 'package:shop_flutter/src/products/providers/products_data_provider.dart';
import 'package:shop_flutter/src/products/views/product_detail.dart';
import 'package:shop_flutter/src/products/widgets/product_list_item.dart';
import 'package:shop_flutter/src/products/widgets/search_bar.dart';

class ProductListScreen extends StatefulWidget {
  final Category? category;
  final String? searchText;

  const ProductListScreen({
    Key? key,
    this.category,
    this.searchText,
  }) : super(key: key);

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductsDataProvider dataProvider = ProductsDataProvider();
  final _scrollController = ScrollController();

  final GlobalKey listViewKey = GlobalKey();
  String appBarTitle = 'Каталог';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    dataProvider.addListener(onDataProviderChanged);
    var category = widget.category;
    print('Category ${category?.title}');
    // dataProvider.category = category;
    loadData();
  }

  @override
  void dispose() {
    dataProvider.removeListener(onDataProviderChanged);
    _scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void onDataProviderChanged() {
    setState(() {});
  }

  Future<void> loadData() async {
    var category = widget.category;
    var searchText = widget.searchText;
    if (category != null) {

        appBarTitle = category.title!;

    }
    print(category?.title);
    print('searchText $searchText');
    dataProvider.getProductsData(
        categoryId: category?.categoryId, searchText: searchText);
  }

  void _onScroll() {
    // print(_scrollController.position.extentAfter);
    if (_isBottom && !dataProvider.loading) {
      loadData();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    var searchText = widget.searchText;
    return Scaffold(
      appBar: SearchAppBar(
        searchText: searchText,
      ),
      body: buildBody(context),
    );
  }

  Widget buildListViewPlaceHolder(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget buildGestureDetector(BuildContext context, Product product) {
    return GestureDetector(
      onTap: () {
        onListViewItemTap(
          context,
          product,
        );
      },
      child: ProductListItem(
        product: product,
      ),
    );
  }

  Widget buildListView(BuildContext context) {
    return ListView.builder(
      // key: listViewKey,
      controller: _scrollController,
      itemCount: dataProvider.allProducts.length,
      itemBuilder: (BuildContext context, int index) {
        Product product = dataProvider.allProducts[index];
        print(product.imageUrl);
        return buildGestureDetector(context, product);
      },
      scrollDirection: Axis.vertical,
    );
  }

  void onListViewItemTap(BuildContext context, Product product) async {
    product.productDescription = "local description";
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductDetailPage(
          product: product,
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Scaffold(
      body: Container(
        child: dataProvider.loading && dataProvider.allProducts.isEmpty
            ? buildProgressIndicator()
            : buildListView(context),
      ),
    );
  }

  Widget buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
