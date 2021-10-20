import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_flutter/src/products/views/product_screen.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? searchText;

  SearchAppBar({
    Key? key,
    this.searchText,
  })  : preferredSize = Size.fromHeight(60.0),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  _SearchAppBarState createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  final searchTextFieldController = TextEditingController();
  String appBarTitle = 'Каталог';

  Icon customIcon = Icon(Icons.search);
  Widget customSearchBar = Text('Каталог');

  @override
  Widget build(BuildContext context) {
    var searchText = widget.searchText;

    return AppBar(
      centerTitle: true,
      title: searchText == null ? customSearchBar : Text(searchText),
      actions: [
        if (searchText == null)
          IconButton(
            onPressed: () {
              buildSearchBar();
              setState(() {});
            },
            icon: customIcon,
          ),
      ],
    );
  }

  Widget buildTextField(BuildContext context) {
    return TextField(
      autofocus: true,
      cursorColor: Colors.cyan,
      controller: searchTextFieldController,
      onSubmitted: (item) {
        searchTextFieldController.clear();
        customIcon = Icon(Icons.search);
        customSearchBar = Text(appBarTitle);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductListScreen(
              searchText: item.toString(),
            ),
          ),
        );
      },
      decoration: InputDecoration(
        hintText: 'Название продукта...',
        hintStyle: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontStyle: FontStyle.normal,
        ),
        border: InputBorder.none,
      ),
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }

  void buildSearchBar() {
    if (customIcon.icon == Icons.search) {
      customIcon = const Icon(Icons.cancel);
      customSearchBar = buildTextField(context);
    } else {
      customIcon = Icon(Icons.search);
      customSearchBar = Text(appBarTitle);
    }
  }
}
