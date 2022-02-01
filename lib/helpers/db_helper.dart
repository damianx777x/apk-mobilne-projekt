import 'package:kcall_app/entities/ingredient.dart';
import 'package:kcall_app/entities/meal.dart';
import 'package:kcall_app/entities/meal_to_display.dart';
import 'package:kcall_app/entities/product.dart';
import 'package:kcall_app/entities/product_category.dart';
import 'package:kcall_app/entities/recipe.dart';
import 'package:kcall_app/entities/weight_measurement.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Future<Database> getDatabase() async {
    final db = openDatabase(
      join(
        await getDatabasesPath(),
        'kcall_app.db',
      ),
      // app db structure creation
      onCreate: (database, version) {
        database.execute(
            "CREATE TABLE weightMeasurements (id INTEGER PRIMARY KEY AUTOINCREMENT, weightInKg REAL, date TEXT)");
        database.execute(
            "CREATE TABLE productCategories (id INTEGER PRIMARY KEY, name TEXT)");
        database.execute(
            "CREATE TABLE products (id INTEGER PRIMARY KEY , name TEXT, category INTEGER, kcall INTEGER,protein INTEGER, fat INTEGER, carbs INTEGER)");
        database.execute(
            "CREATE TABLE recipes (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, description TEXT, photoPath TEXT)");
        database.execute(
            "CREATE TABLE ingredients (id INTEGER PRIMARY KEY AUTOINCREMENT, idProduct INTEGER, amount INTEGER, idRecipe INTEGER)");
        database.execute(
            "CREATE TABLE meals (id INTEGER PRIMARY KEY AUTOINCREMENT, idProduct INTEGER, amount INTEGER, date TEXT)");

        database.insert("productCategories", {"id": 1, "name": "Napoje"});
        database.insert("productCategories", {"id": 2, "name": "Mięso i ryby"});
        database.insert("productCategories", {"id": 3, "name": "Moje dania"});
        database.insert("productCategories", {"id": 4, "name": "Produkty zbożowe, kasze, ryże"});
        database.insert("productCategories", {"id": 5, "name": "Słodycze"});
        database.insert("productCategories", {"id": 6, "name": "Produkty sypkie"});
        database.insert("productCategories", {"id": 7, "name": "Tłuszcze"});
        database.insert("productCategories", {"id": 8, "name": "Przyprawy"});
        database.insert("productCategories", {"id": 9, "name": "Fast-food"});
        database.insert("productCategories", {"id": 10, "name": "Dania"});
        database.insert("productCategories", {"id": 11, "name": "Posiłki pakowane"});
        database.insert("productCategories", {"id": 12, "name": "Warzywa"});
        database.insert("productCategories", {"id": 13, "name": "Owoce"});
        database.insert("productCategories", {"id": 14, "name": "Orzechy i nasiona"});
        database.insert("productCategories", {"id": 16, "name": "Pieczywo"});
        database.insert("productCategories", {"id": 15, "name": "Dodatki do pieczenia"});
        database.insert("products", {
          "name": "Pepsi",
          "kcall": 43,
          "category": 1,
          "fat": 0,
          "protein": 0,
          "carbs": 11,
        });
        database.insert("products", {
          "name": "Kawa",
          "kcall": 1,
          "category": 1,
          "fat": 0,
          "protein": 0,
          "carbs": 0,
        });
      },
      version: 1,
    );
    return db;
  }

  static Future<void> editProduct(Product product, int id) async {
    final db = await getDatabase();
    await db.update("products", product.toMap(),where: "id = $id");
  }

  static Future<void> insertProduct(Product product) async {
    
    final db = await getDatabase();
    db.insert("products", product.toMap());

  }

  static Future<void> insertWeightMeasurement(
      WeightMeasuerement weightMeasuerement) async {
    final db = await getDatabase();
    await db.insert("weightMeasurements", weightMeasuerement.toSqlMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<WeightMeasuerement>> getAllWeightMeasurements() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> weightMeasurementsAsMaps =
        await db.query("weightMeasurements");
    return List.generate(weightMeasurementsAsMaps.length, (index) {
      return WeightMeasuerement.fromSql(
        weightInKg: weightMeasurementsAsMaps[index]["weightInKg"],
        date: weightMeasurementsAsMaps[index]["date"],
      );
    });
  }

  static Future<List<ProductCategory>> getAllProductCategories() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> productCategories =
        await db.query("productCategories", orderBy: "name");
    return List.generate(productCategories.length, (index) {
      return ProductCategory.fromMap(productCategories[index]);
    });
  }

  static Future<List<Product>> getAllProductsFromCategory(
      int categoryId) async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> productsFromCategory =
        await db.query("products", where: "category = ${categoryId}");
    return List.generate(productsFromCategory.length, (index) {
      return Product.fromMap(productsFromCategory[index]);
    });
  }

  static Future<void> insertMeal(Meal meal) async {
    final db = await getDatabase();
    await db.insert("meals", meal.toMap());
  }

  static Future<List<MealToDisplay>> getMealsFromDay(String day) async {
    final db = await getDatabase();
    List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT m.id, m.amount, m.date, p.kcall, p.protein, p.fat, p.carbs, p.name from meals m inner join products p on m.idProduct = p.id where date = '$day'");
    return List.generate(maps.length, (index) {
      return MealToDisplay.fromMap(maps[index]);
    });
  }

  static Future<List<Recipe>> getAllRecipes() async {
    final db = await getDatabase();
    List<Map<String, dynamic>> maps = await db.query("recipes");
    return List.generate(maps.length, (index) {
      return Recipe.fromMap(maps[index]);
    });
  }

  static Future<void> deleteMeal(int id) async {
    final db = await getDatabase();
    db.delete("meals", where: "id = $id");
  }

  static Future<Product> getProductById(int id) async {
    final db = await getDatabase();
    List list = await db.query("products", limit: 1, where: "id = $id");
    Product product = Product.fromMap(list.first as Map<String, dynamic>);
    print(product.name);
    return product;
  }

  static Future<void> deleteProductById(int id) async {
    final db = await getDatabase();
    await db.delete("products", where: "id = $id");
  }

  static Future<List<Map<String,dynamic>>> getDates() async {
    final db = await getDatabase();
    List<Map<String,dynamic>> dates = await db.rawQuery("SELECT distinct date from meals");
    return dates;
  }
  
  static Future<void> insertRecipe(Map<String, dynamic> map, List<Ingredient> list) async {
    final db = await getDatabase();
    int id = await db.insert("recipes", map);
    for(Ingredient i in list) {
      i.idRecipe = id;
      db.insert("ingredients", i.toMap());
    }
  }

  static Future<Recipe> getRecipeById(int id) async {
    final db = await getDatabase();
    return Recipe.fromMap((await db.query("recipes", where: "id=$id",limit: 1)).first);

  }

  static Future<void> deleteRecipeById(int id) async {
    final db = await getDatabase();
    await db.delete("recipes", where: "id=$id");
    await db.delete("ingredients", where: "idRecipe=$id");
  }

  static Future<List<Ingredient>> getIngredientsForRecipe(int id) async {
    final db = await getDatabase();
    List<Map<String, dynamic>> list = await db.query("ingredients", where: "idRecipe = $id");
    List<Ingredient> listIngredient = <Ingredient>[];
    for (Map<String,dynamic> map in list) {
      listIngredient.add(Ingredient.fromMap(map));
    } 
    return listIngredient;
  }

}
