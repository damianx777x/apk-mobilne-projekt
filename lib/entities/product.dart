import 'package:flutter/foundation.dart';

class Product {
  late String _name;
  late int _kcall;
  late int _protein;
  late int _fat;
  late int _carbs;
  late int _categoryId;
  late int _productId;

  Product(
      {required name,
      required kcall,
      required protein,
      required fat,
      required carbs,
      required categoryId,
      required productId}) {
    _name = name;
    _kcall = kcall;
    _protein = protein;
    _fat = fat;
    _carbs = carbs;
    _categoryId = categoryId;
    _productId = productId;
  }

  Product.forSqlInsertion({
    required name,
    required kcall,
    required protein,
    required fat,
    required carbs,
    required categoryId,
  }) {
    _name = name;
    _kcall = kcall;
    _protein = protein;
    _fat = fat;
    _carbs = carbs;
    _categoryId = categoryId;
  }

  int get kcall => _kcall;
  int get protein => _protein;
  int get fat => _fat;
  int get carbs => _carbs;
  int get id => _productId;
  String get name => _name;
  int get categoryId => _categoryId;


  Map<String, dynamic> toMap() {
    return {
      "name": _name,
      "kcall": _kcall,
      "protein": _protein,
      "fat": _fat,
      "carbs": _carbs,
      "category": _categoryId
    };
  }

  Product.fromMap(Map<String, dynamic> map) {
    _kcall= map["kcall"];
    _carbs= map["carbs"];
    _categoryId= map["category"];
    _fat= map["fat"];
    _name= map["name"];
    _protein= map["protein"];
    _productId= map["id"];
    
  }
}
