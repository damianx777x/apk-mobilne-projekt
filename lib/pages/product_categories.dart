import 'package:flutter/material.dart';
import 'package:kcall_app/entities/product_category.dart';
import 'package:kcall_app/helpers/db_helper.dart';
import 'package:kcall_app/pages/products.dart';

class ProductsCategoriesList extends StatefulWidget {
  const ProductsCategoriesList({Key? key}) : super(key: key);

  @override
  _ProductsCategoriesListState createState() => _ProductsCategoriesListState();
}

class _ProductsCategoriesListState extends State<ProductsCategoriesList> {
  late Future<Widget> categoriesList;

  Future<Widget> getProductsCategoriesList() async {
    List<ProductCategory> productCategories =
        await DBHelper.getAllProductCategories();
    return ListView.builder(
      itemCount: productCategories.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(productCategories[index].name),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductsList(productCategories[index].id),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void initState() {
    categoriesList = getProductsCategoriesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista produktów"),
      ),
      body: FutureBuilder(
          future: categoriesList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data as Widget;
            } else {
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.add),
      ),
    );
  }
}
