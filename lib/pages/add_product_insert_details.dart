import 'package:flutter/material.dart';
import 'package:kcall_app/entities/product.dart';
import 'package:kcall_app/helpers/db_helper.dart';
import 'package:kcall_app/pages/product_categories.dart';

class AddProductInsertDetails extends StatelessWidget {
  TextEditingController name = TextEditingController();
  TextEditingController kcall = TextEditingController();
  TextEditingController protein = TextEditingController();
  TextEditingController carbs = TextEditingController();
  TextEditingController fat = TextEditingController();
  int _categoryid;

  AddProductInsertDetails(int categoryId) : _categoryid = categoryId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Podaj informacje o produkcie: "),
        ),
        body: ListView(
          padding: EdgeInsets.all(8),
          children: [
            Text("Nazwa produktu"),
            TextFormField(
              controller: name,
            ),
            Text("Kcall w 100 g produktu: "),
            TextFormField(
              controller: kcall,
            ),
            Text("Makroskładniki w 100g produktu: "),
            Text("Węglowodany [g] : "),
            TextFormField(
              controller: carbs,
            ),
            Text("Białko [g] :"),
            TextFormField(
              controller: protein,
            ),
            Text("Tłuszcz [g]"),
            TextFormField(
              controller: fat,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    DBHelper.insertProduct(Product.forSqlInsertion(
                        name: name.text,
                        kcall: int.parse(kcall.text),
                        protein: int.parse(protein.text),
                        fat: int.parse(fat.text),
                        carbs: int.parse(carbs.text),
                        categoryId: _categoryid));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductsCategoriesList()));
                  },
                  child: Text("Dodaj produkt"),
                ),
              ],
            ),
          ],
        ));
  }
}
