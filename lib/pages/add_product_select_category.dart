import 'package:flutter/material.dart';
import 'package:kcall_app/entities/product_category.dart';
import 'package:kcall_app/helpers/db_helper.dart';
import 'package:kcall_app/pages/add_product_insert_details.dart';

class AddProductSelectCategory extends StatefulWidget {
  AddProductSelectCategory();
  @override
  _AddProductSelectCategoryState createState() =>
      _AddProductSelectCategoryState();
}

class _AddProductSelectCategoryState extends State<AddProductSelectCategory> {
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
                      builder: (context) => AddProductInsertDetails(
                          productCategories[index].id)));
            });
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
        title: const Text("Wybierz kategorię dla nowego produktu: "),
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
    );
  }
}
