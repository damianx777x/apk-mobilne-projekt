import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kcall_app/entities/add_recipe_state.dart';
import 'package:kcall_app/entities/ingredient.dart';
import 'package:kcall_app/entities/meal_to_display.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kcall_app/entities/product.dart';
import 'package:kcall_app/entities/recipe.dart';
import 'package:kcall_app/helpers/db_helper.dart';
import 'package:kcall_app/pages/add_ingredient_to_recipe.dart';
import 'package:kcall_app/pages/recipes_list.dart';

class AddRecipe extends StatefulWidget {
  RecipeState? rs = RecipeState();
  AddRecipe(RecipeState? rs) {
    if (rs != null) this.rs = rs;
  }

  @override
  AddRecipeState createState() => AddRecipeState(rs);
}

class AddRecipeState extends State<AddRecipe> {
  AddRecipeState(RecipeState? rs) : this.rs = rs;

  List<MealToDisplay>? ingredients;
  RecipeState? rs;
  File? file;
  Image? image;
  ImagePicker imagePicker = ImagePicker();
  TextEditingController nameController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    file = rs!.image;// TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int kcall = 0;
    int protein = 0;
    int fat = 0;
    int amount = 1;
    int carbs = 0;
    //file = rs!.image;
    if (rs!.ingredients!.isNotEmpty) {
      for (Ingredient i in rs!.ingredients!) {
        kcall += i.kcall;
        fat += i.fat;
        protein += i.protein!;
        carbs += i.carbs;
        amount += i.amount;
      }
      kcall = (kcall*100/amount).floor();
      protein = (protein*100/amount).floor();
      fat = (fat*100/amount).floor();
      carbs = (carbs*100/amount).floor();
    }

    nameController.text = rs!.name!;
    descriptionController.text = rs!.description!;
    return Scaffold(
        appBar: AppBar(
          title: Text("Dodaj przepis"),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(
            vertical: 2,
            horizontal: 5,
          ),
          child: ListView(
            children: [
              Container(
                child: Row(
                  children: [
                    Text("Nazwa przepisu: "),
                  ],
                ),
                margin: EdgeInsets.symmetric(vertical: 5),
              ),
              Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 3),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  captureMealPhoto();
                },
                child: Text("Dodaj zdjęcie"),
              ),
              if (file != null)
                Image.file(
                  file!,
                  height: 200,
                  width: 200,
                ),
              if (file == null) Icon(Icons.no_photography_rounded),
              Container(
                child: Row(
                  children: [Text("Lista składników: ")],
                ),
                margin: EdgeInsets.symmetric(vertical: 2),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        rs!.name = nameController.text;
                        rs!.description = descriptionController.text;
                        rs!.image = file;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddIngredientCategory(rs),
                          ),
                        );
                      },
                      child: Text("Dodaj składnik"))
                ],
              ),
              if (rs!.ingredients!.isNotEmpty)
                ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: rs!.ingredients!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          subtitle: Text(
                              "${rs!.ingredients![index].kcall} Kcall Białko: ${rs!.ingredients![index].protein} g Węglowodany ${rs!.ingredients![index].carbs} g Tłuszcz ${rs!.ingredients![index].fat} g"),
                          title: Text(
                              "${rs!.ingredients![index].name} ${rs!.ingredients![index].amount}g"));
                    }),
              
              if (rs!.ingredients!.isNotEmpty)
                ListTile(
                  title: Text("Skłądniki odżywcze na 100 g"),
                ),
              if (rs!.ingredients!.isNotEmpty)
                ListTile(
                  title: Text("Kcall: $kcall"),
                ),
              if (rs!.ingredients!.isNotEmpty)
                ListTile(
                  title: Text("Białko: $protein g"),
                ),
              if (rs!.ingredients!.isNotEmpty)
                ListTile(
                  title: Text("Węglowodany: $carbs g"),
                ),
              if (rs!.ingredients!.isNotEmpty)
                ListTile(
                  title: Text("Tłuszcz: $fat g"),
                ),
              Row(
                children: [Text("Opis przygotowania:")],
              ),
              Row(
                children: [
                  Flexible(
                      child: TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3))),
                    minLines: 6,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                  ))
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    String? path = null;
                    if (file != null) {
                      List<int> bytes = file!.readAsBytesSync();
                      path = base64Encode(bytes);
                    }
                    DBHelper.insertProduct(Product.forSqlInsertion(name: nameController.text, kcall: kcall, protein: protein, fat: fat, carbs: carbs, categoryId: 3));
                    DBHelper.insertRecipe(
                        Recipe(
                                name: nameController.text,
                                description: descriptionController.text,
                                photoPath: path)
                            .toMap(),
                        rs!.ingredients!);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipesListLoader(),
                      ),
                    );
                  },
                  child: Text("Zapisz przepis"))
            ],
          ),
        ));
  }

  Future<XFile?>? captureMealPhoto() async {
    rs!.name = nameController.text;
    rs!.description = descriptionController.text;
    
    XFile? photoPath2 = await imagePicker.pickImage(source: ImageSource.camera);

    print(photoPath2!.path);
    setState(() {
      file = File(photoPath2.path);
    });

    return photoPath2;
  }
}
