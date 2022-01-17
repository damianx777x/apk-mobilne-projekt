import 'package:flutter/material.dart';
import 'package:kcall_app/entities/product.dart';

class EditProduct extends StatelessWidget {
  late String name;

  EditProduct(Product product) {
    name = product.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edytuj produkt"),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(8),
        children: [
          Text("Nazwa produktu: "),
          TextFormField(decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3))),),
         
          Text("Kcall na 100 g: "),
           TextFormField(decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3))),),
      
          Text("Makroskładniki w 100g produktu: "),
          Text("Weglowodany [g]: "),
           TextFormField(decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3))),),
         
          Text("Białko [g]: "),
           TextFormField(decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3))),),
         
          Text("Tłuszcz [g]: "),
          TextFormField(decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3))),),
          
        ],
      ),
    );
  }
}
