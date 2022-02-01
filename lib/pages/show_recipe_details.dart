import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kcall_app/entities/ingredient.dart';
import 'package:kcall_app/entities/product.dart';
import 'package:kcall_app/entities/recipe.dart';
import 'package:kcall_app/helpers/db_helper.dart';
import 'package:kcall_app/pages/recipes_list.dart';
import 'package:path/path.dart';

class RecipeDetails extends StatefulWidget {
  int id;

  RecipeDetails(int id) : this.id = id;
  @override
  RecipeDetailsState createState() => RecipeDetailsState(id);
}

class RecipeDetailsState extends State<RecipeDetails> {
  int id;
  late Future future;
  int kcallSum = 0;
  int proteinSum = 0;
  int fatSum = 0;
  int carbsSum = 0;
  RecipeDetailsState(int id) : this.id = id;

  Future<Widget> getDetails() async {
    Recipe recipe = await DBHelper.getRecipeById(id);
    List<Ingredient> ingredients = await DBHelper.getIngredientsForRecipe(id);
    for (Ingredient i in ingredients) {
      Product product = await DBHelper.getProductById(i.idProduct);
      i.fat = (product.fat / i.amount *100).floor();
      i.protein = (product.protein/i.amount*100).floor();
      i.kcall = (product.kcall /i.amount * 100).floor();
      i.carbs = (product.carbs / i.amount *100).floor();
      i.name = product.name;

      proteinSum += i.protein!;
      fatSum += i.fat;
      carbsSum += i.carbs;
      kcallSum += i.kcall;
    }

    return ListView(children: [
      ListTile(title: Text(recipe.name!)),
      if (recipe.photoPath != null)
        Image.memory(
          base64Decode(recipe.photoPath!),
          width: 300,
          height: 300,
        )
      else
        Icon(Icons.no_photography_rounded),
      ListTile(title: Text("Lista składników")),
      ListView.builder(
          itemCount: ingredients.length,
          primary: false,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("${ingredients[index].name} ${ingredients[index].amount.toString()} g"),
            );
          }),
      ListTile(
        title: Text("Sposób przygotowania"),
      ),
      Container(
        child: Row(
          children: [Text(recipe.description!)],
        ),
        padding: EdgeInsets.only(left: 16, right: 16),
      ),
      ListTile(title: Text("Wartości odżywcze na 100 g produktu:")),
      ListTile(
        title: Text("${kcallSum} kcall"),
      ),
      ListTile(
        title: Text("Węglowodany ${carbsSum} g"),
      ),
      ListTile(
        title: Text("Białko ${proteinSum} g"),
      ),
      ListTile(
        title: Text("Tłuszcz ${fatSum} g"),
      ),
    ]);
  }

  @override
  void initState() {
    future = getDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                DBHelper.deleteRecipeById(id);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RecipesListLoader()));
              },
              icon: Icon(Icons.delete))
        ],
        title: Text("Przepis"),
      ),
      body: FutureBuilder(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return snapshot.data as Widget;
            else
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
          }),
    );
  }
}
