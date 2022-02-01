import 'dart:io';

import 'package:kcall_app/entities/ingredient.dart';

class RecipeState {

  String? name = "";
  String? description = "";
  File? image;
  List<Ingredient>? ingredients = <Ingredient>[];
  RecipeState(
   
     
    
  );


  addIngredient(Ingredient i) {
    ingredients!.add(i);
  }
}