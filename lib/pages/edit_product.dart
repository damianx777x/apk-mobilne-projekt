import 'package:flutter/material.dart';
import 'package:kcall_app/entities/product.dart';
import 'package:kcall_app/helpers/db_helper.dart';
import 'package:kcall_app/pages/product_categories.dart';

class EditProduct extends StatelessWidget {
  late int id ;
  late int cateegoryId;
  TextEditingController name = TextEditingController();
  TextEditingController kcall = TextEditingController();
  TextEditingController protein = TextEditingController();
  TextEditingController carbs = TextEditingController();
  TextEditingController fat = TextEditingController();

  EditProduct(Product product) {
    name.text = product.name;
    kcall.text = product.kcall.toString();
    protein.text = product.protein.toString();
    carbs.text = product.carbs.toString();
    fat.text = product.fat.toString();
    id = product.id;
    cateegoryId = product.categoryId;
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
          TextFormField(
            controller: name,
            decoration: InputDecoration(
              
                border: OutlineInputBorder(borderSide: BorderSide(width: 3))),
          ),
          Text("Kcall na 100 g: "),
          TextFormField(
            controller: kcall,
            decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide(width: 3))),
          ),
          Text("Makroskładniki w 100g produktu: "),
          Text("Weglowodany [g]: "),
          TextFormField(
            controller: carbs,
            decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide(width: 3))),
          ),
          Text("Białko [g]: "),
          TextFormField(
            controller: protein,
            decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide(width: 3))),
          ),
          Text("Tłuszcz [g]: "),
          TextFormField(
            controller: fat,
            decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide(width: 3))),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  DBHelper.editProduct(Product.forSqlInsertion(name: name.text, kcall: int.parse(kcall.text), protein: int.parse(protein.text), fat: int.parse(fat.text), carbs: int.parse(carbs.text), categoryId: cateegoryId), id);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductsCategoriesList()));
                },
                child: Text("Zapisz zmiany"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
