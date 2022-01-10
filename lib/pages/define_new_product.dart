import 'package:flutter/material.dart';

class AddNewProduct extends StatelessWidget {

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dodaj nowy produkt spożywczy"),
      ),
      body: Column(
        children: [
          Row(
            children: [Text("Nazwa porduktu: ")],
          ),
          Row(
            children: [Text("Kaloryczność: ")],
          ),
          Row(
            children: [Text("Węglowodany: ")],
          ),
          Row(
            children: [Text("Białko: ")],
          ),
          Row(
            children: [Text("Tłuszcz: ")],
          ),
        ],
      ),
    );
  }
}
