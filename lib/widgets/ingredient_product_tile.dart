import 'package:flutter/material.dart';
import 'package:kcall_app/entities/add_recipe_state.dart';
import 'package:kcall_app/entities/product.dart';
import 'package:kcall_app/pages/add_ingredient_to_recipe.dart';
import 'package:kcall_app/pages/add_meal_amount.dart';
import 'package:kcall_app/widgets/ingredient_category_tile.dart';

class IngredientProductTile extends StatelessWidget {
  late Product _product;
  RecipeState? rs;

  IngredientProductTile(Product product, RecipeState? rs) {
    _product = product;
    this.rs = rs;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("${_product.name}  ${_product.kcall} kcall/100g"),
      subtitle: Text(
          "Białko: ${_product.protein} g Węglowodany: ${_product.carbs}  Tłuszcz: ${_product.fat}"),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddIngerdientAmount(rs, _product),
          ),
        );
      },
    );
  }
}
