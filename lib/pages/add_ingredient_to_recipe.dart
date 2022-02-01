import 'package:flutter/material.dart';
import 'package:kcall_app/entities/add_recipe_state.dart';
import 'package:kcall_app/entities/ingredient.dart';
import 'package:kcall_app/entities/product.dart';
import 'package:kcall_app/entities/product_category.dart';
import 'package:kcall_app/helpers/db_helper.dart';
import 'package:kcall_app/pages/add_recipe.dart';
import 'package:kcall_app/widgets/ingredient_category_tile.dart';
import 'package:kcall_app/widgets/ingredient_product_tile.dart';
import 'package:kcall_app/widgets/meal_category_tile.dart';
import 'package:path/path.dart';

class AddIngredientCategory extends StatefulWidget {
  RecipeState? rs;
  AddIngredientCategory(RecipeState? rs) : this.rs = rs;

  @override
  _AddIngredientCategoryState createState() => _AddIngredientCategoryState(rs);
}

class _AddIngredientCategoryState extends State<AddIngredientCategory> {
  _AddIngredientCategoryState(RecipeState? rs) : this.rs = rs;
  late Future<Widget> categoryList;
  RecipeState? rs;
  @override
  void initState() {
    categoryList = showCategories();
    super.initState();
  }

  Future<Widget> showCategories() async {
    List<ProductCategory> categories = await DBHelper.getAllProductCategories();
    return ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return IngredientCategoryTile(categories[index], rs);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wybierz kategorię"),
      ),
      body: FutureBuilder(
        future: categoryList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data as Widget;
          } else
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
        },
      ),
    );
  }
}

class AddIngredientProduct extends StatefulWidget {
  RecipeState? rs;

  AddIngredientProduct(int id, RecipeState? rs) {
    this.rs = rs;
    _id = id;
  }

  late int _id;

  @override
  AddIngredientProductState createState() => AddIngredientProductState(_id, rs);
}

class AddIngredientProductState extends State {
  late int _categoryId;
  late Future<Widget> products;

  RecipeState? rs;

  AddIngredientProductState(int id, RecipeState? rs) {
    this.rs = rs;
    _categoryId = id;
  }

  Future<Widget> getProducts(int categoryId) async {
    var products = await DBHelper.getAllProductsFromCategory(categoryId);
    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return IngredientProductTile(products[index], rs);
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    products = getProducts(_categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wybierz produkt"),
      ),
      body: FutureBuilder(
          future: products,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data as Widget;
            } else {
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

class AddIngerdientAmount extends StatelessWidget {
  RecipeState? rs;
  Product product;
  TextEditingController textEditingController = TextEditingController();

  AddIngerdientAmount(RecipeState? rs, Product product)
      : this.rs = rs,
        this.product = product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Podaj ilość składnika"),
      ),
      body: Column(
        children: [
          Row(
            children: [Text("Podaj wagę produktu:")],
          ),
          Row(
            children: [
              Flexible(
                child: TextFormField(
                  controller: textEditingController,
                ),
              ),
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    int amnt = int.parse(textEditingController.text);
                    rs!.addIngredient(Ingredient(
                        amount: amnt,
                        idProduct: product.id,
                        name: product.name,
                        protein: (product.protein/100*amnt).floor(),
                        fat: (product.fat/100*amnt).floor(),
                        kcall: (product.kcall/100*amnt).floor(),
                        carbs: (product.carbs/100*amnt).floor()));
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddRecipe(rs)));
                  },
                  child: Text("Dodaj składnik"))
            ],
          )
        ],
      ),
    );
  }
}
