import 'package:flutter/material.dart';
import 'package:kcall_app/entities/product_category.dart';
import 'package:kcall_app/helpers/db_helper.dart';
import 'package:kcall_app/widgets/ingredient_product_tile.dart';
import 'package:kcall_app/widgets/meal_category_tile.dart';
import 'package:path/path.dart';

class AddIngredientCategory extends StatefulWidget {
  @override
  _AddIngredientCategoryState createState() => _AddIngredientCategoryState();
}

class _AddIngredientCategoryState extends State<AddIngredientCategory> {
  late Future<Widget> categoryList;

  @override
  void initState() {
    categoryList = showCategories();
    super.initState();
  }

  Future<Widget> showCategories() async {
    List<ProductCategory> categories = await DBHelper.getAllProductCategories();
    return ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return MealCategoryTile(categories[index]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wybierz kategorię"),
      ),
      body: FutureBuilder(
        future: categoryList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data as Widget;
          } else
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
        },
      ),
    );
  }
}


class AddIngredientProduct extends StatefulWidget {
  AddIngredientProduct(int id) {
    _id = id;
  }

  late int _id;

  @override
  AddIngredientProductState createState() => AddIngredientProductState(_id);
}

class AddIngredientProductState extends State {
  late int _categoryId;
  late Future<Widget> products;

  AddIngredientProductState(int id) {
    _categoryId = id;
  }

  Future<Widget> getProducts(int categoryId) async {
    var products = await DBHelper.getAllProductsFromCategory(categoryId);
    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return IngredientProductTile(products[index]);
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

class AddMeal_Category extends StatefulWidget {
  @override
  AddMeal_CategoryState createState() => AddMeal_CategoryState();
}

class AddMeal_CategoryState extends State {
  late Future<Widget> categories;

  @override
  void initState() {
    super.initState();
    categories = showCategories();
  }

  Future<Widget> showCategories() async {
    final categoriesEntities = await DBHelper.getAllProductCategories();
    return ListView.builder(itemCount: categoriesEntities.length, itemBuilder: (context, index) {
      return MealCategoryTile(categoriesEntities[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wybierz kategorię produktu"),
      ),
      body: FutureBuilder(
          future: categories,
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