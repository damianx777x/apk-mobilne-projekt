import 'package:flutter/material.dart';

class AddRecipe extends StatefulWidget {
  @override
  AddRecipeState createState() => AddRecipeState();
}

class AddRecipeState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dodaj nowy przepis"),
        
      ),
    );
  }
}
