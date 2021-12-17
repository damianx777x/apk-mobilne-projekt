class Ingredient {
  late int _amount;
  late int _idProduct;
  late int _idRecipe;

  Ingredient({required int amount, required int idProduct, required int idRecipe}) {
    _amount = amount;
    _idProduct = idProduct;
    _idRecipe = idRecipe;
  }

  Map<String, dynamic> toMap() {
    return {
      "amount" : _amount,
      "idRecipe" : _idRecipe,
      "idProduct" : _idProduct 
    };
  }

}