import 'package:flutter/material.dart';
import 'package:kcall_app/helpers/db_helper.dart';
import 'package:kcall_app/widgets/meal_category_tile.dart';
import 'package:path/path.dart';

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
