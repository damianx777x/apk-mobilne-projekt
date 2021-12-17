import 'package:flutter/material.dart';
import 'package:kcall_app/helpers/db_helper.dart';
import 'package:kcall_app/pages/add_meal_category.dart';
import 'package:kcall_app/widgets/meal_product_tile.dart';

class AddMeal_Product extends StatefulWidget {
  AddMeal_Product(int id) {
    _id = id;
  }

  late int _id;

  @override
  AddMeal_ProductState createState() => AddMeal_ProductState(_id);
}

class AddMeal_ProductState extends State {
  late int _categoryId;
  late Future<Widget> products;

  AddMeal_ProductState(int id) {
    _categoryId = id;
  }

  Future<Widget> getProducts(int categoryId) async {
    var products = await DBHelper.getAllProductsFromCategory(categoryId);
    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductTile(products[index]);
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    products = getProducts(_categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wybierz produkt"),
      ),
      body: FutureBuilder(
          future: products,
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
