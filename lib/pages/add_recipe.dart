import 'package:flutter/material.dart';
import 'package:kcall_app/entities/meal_to_display.dart';
import 'package:image_picker/image_picker.dart';

class AddRecipe extends StatefulWidget {
  @override
  AddRecipeState createState() => AddRecipeState();
}

class AddRecipeState extends State<AddRecipe> {
  List<MealToDisplay>? ingredients;
  ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dodaj przepis"),
      ),
      body: ListView(
        children: [
          Row(
            children: [
              Text("Nazwa przepisu: "),
            ],
          ),
          Row(
            children: [
              Flexible(child: TextFormField()),
            ],
          ),
         
          Row(
            children: [Text("Lista składników")],
          ),
          ListView(
            shrinkWrap: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: null, child: Text("Dodaj składnik"))
            ],
          ),
          
          Row(
            children: [Text("Opis przygotowania:")],
          ),
          Row(
            children: [
              Flexible(
                  child: TextFormField(
                decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide(width: 3))
                ),
                minLines: 6,
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ))
            ],
          ),
          ElevatedButton(
              onPressed: captureMealPhoto, child: Text("Dodaj zdjęcie"))
        ],
      ),
    );
  }

  captureMealPhoto() {
    imagePicker.pickImage(source: ImageSource.camera);
  }
}
