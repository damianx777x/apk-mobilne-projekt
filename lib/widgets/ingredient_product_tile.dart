import 'package:flutter/material.dart';
import 'package:kcall_app/entities/product.dart';
import 'package:kcall_app/pages/add_meal_amount.dart';

class IngredientProductTile extends StatelessWidget {
  late Product _product;

  IngredientProductTile(Product product) {
    _product = product;
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
            builder: (context) => AddMeal_Amount(_product.id),
          ),
        );
      },
    );
  }
}
