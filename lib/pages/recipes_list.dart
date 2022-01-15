import 'package:flutter/material.dart';
import 'package:kcall_app/entities/recipe.dart';
import 'package:kcall_app/helpers/db_helper.dart';
import 'package:kcall_app/pages/add_recipe.dart';

class RecipesListLoader extends StatefulWidget {
  @override
  _RecipesListLoaderState createState() => _RecipesListLoaderState();
}

class _RecipesListLoaderState extends State<RecipesListLoader> {
  late Future future;

  Future<Widget> createPage() async {
    List<Recipe> recipes = await DBHelper.getAllRecipes();
    return RecipesList(recipes);
  }

  @override
  void initState() {
    future = createPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return snapshot.data as Widget;
          else
            return Container(
              child: CircularProgressIndicator(),
              alignment: Alignment.center,
            );
        });
  }
}

class RecipesList extends StatefulWidget {
  List<Recipe> recipes;
  RecipesList(this.recipes);

  @override
  _RecipesListState createState() => _RecipesListState(recipes);
}

class _RecipesListState extends State<RecipesList> {
  List<Recipe> recipes;

  _RecipesListState(this.recipes);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista przepisów"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddRecipe(
                  ),
                ),
              );
            },
        child: Icon(Icons.add),
      ),
    );
  }
}
