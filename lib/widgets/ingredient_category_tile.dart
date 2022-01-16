import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kcall_app/entities/product_category.dart';
import 'package:kcall_app/pages/add_meal_product.dart';

class IngredientCategoryTile extends StatelessWidget {
  late ProductCategory _productCategory;

  IngredientCategoryTile(ProductCategory productCategory) {
    _productCategory = productCategory;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_productCategory.name),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddMeal_Product(_productCategory.id)));
      },
    );
  }
}
