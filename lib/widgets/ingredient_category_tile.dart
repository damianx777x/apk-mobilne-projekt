import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kcall_app/entities/add_recipe_state.dart';
import 'package:kcall_app/entities/product_category.dart';
import 'package:kcall_app/pages/add_ingredient_to_recipe.dart';
import 'package:kcall_app/pages/add_meal_product.dart';

class IngredientCategoryTile extends StatelessWidget {
  late ProductCategory _productCategory;
  RecipeState? rs;

  IngredientCategoryTile(ProductCategory productCategory, RecipeState? rs) {
    _productCategory = productCategory;
    this.rs = rs;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_productCategory.name),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddIngredientProduct(_productCategory.id,rs)));
      },
    );
  }
}
