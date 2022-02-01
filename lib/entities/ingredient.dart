class Ingredient {
  late int _amount;
  late int _idProduct;
  int? _idRecipe;
  String? _name;
  int? _kcall;
  int? _fat;
  int? _carbs;
  int? protein;

  Ingredient({required int amount, required int idProduct, int? idRecipe, String? name, int? kcall, int? fat, int? carbs, int? protein}) {
    _amount = amount;
    _idProduct = idProduct;
    _idRecipe = idRecipe;
    this.protein = protein;
    this._fat = fat;
    this._kcall = kcall;
    this._name = name;
    this._carbs = carbs;
  }


  

  Ingredient.fromMap(Map<String, dynamic> map) {
    _amount = map["amount"];
    _idProduct=map["idProduct"];
    _idRecipe=map["idRecipe"];
  }
  

  Map<String, dynamic> toMap() {
    return {
      "amount" : _amount,
      "idRecipe" : _idRecipe,
      "idProduct" : _idProduct 
    };
  }


  String get name {
    return _name!;
  }

  int get amount {
    return _amount;
  }

  int get kcall {
    return _kcall!;
  }

  int get fat {
    return _fat!;
  }

  int get carbs {
    return _carbs!;
  }

  int get idProduct {
    return _idProduct;
  }

  int get idRecipe {
    return _idRecipe!;
  }

  set idRecipe(int id) {
    _idRecipe = id;
  } 

  set name(String name) {this._name = name;}
  set kcall(int kcall) {this._kcall = kcall;}
  set proteint(int protein){this.protein = protein;}
  set fat(int fat){this._fat = fat;}
  set carbs(int carbs){this._carbs = carbs;}

}