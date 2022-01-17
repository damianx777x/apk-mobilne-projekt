import 'package:flutter/material.dart';
import 'package:kcall_app/entities/product.dart';
import 'package:kcall_app/helpers/db_helper.dart';
import 'package:kcall_app/pages/edit_product.dart';
import 'package:kcall_app/pages/product_categories.dart';
import 'package:path/path.dart';

class ShowProductDetails extends StatefulWidget {
  int _id;

  ShowProductDetails(int id) : _id = id;

  @override
  _ShowProductDetailsState createState() => _ShowProductDetailsState(_id);
}

class _ShowProductDetailsState extends State<ShowProductDetails> {
  late Future<Widget> productDatails;
  late Product product;

  Future<Widget> getProductDetails() async {
    product = await DBHelper.getProductById(_id);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: [
          IconButton(
            onPressed: () {
               DBHelper.deleteProductById(product.id);
              Navigator.push(this.context, MaterialPageRoute(builder: (context)=>ProductsCategoriesList()));
            },
            icon: Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () {
             
              Navigator.push(this.context, MaterialPageRoute(builder: (context)=>EditProduct(product)));},
            icon: Icon(Icons.edit),
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsetsDirectional.all(8),
        children: [
          Row(
            children: [
              Text("Nazwa produktu: ${product.name}",
                  style: TextStyle(fontWeight: FontWeight.bold))
            ],
          ),
          Divider(
            thickness: 2,
          ),
          Row(
            children: [
              Text("Kcall w 100 g: ${product.kcall} kcall",
                  style: TextStyle(fontWeight: FontWeight.bold))
            ],
          ),
          Divider(
            thickness: 2,
          ),
          Row(
            children: [
              Text(
                "Makroskładniki w 100 g produktu",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [Text("Węglowodany: ${product.carbs} g")],
          ),
          Row(
            children: [Text("Białko: ${product.protein} g")],
          ),
          Row(
            children: [Text("Tłuszcz: ${product.fat} g")],
          ),
        ],
      ),
    );
  }

  int _id;
  _ShowProductDetailsState(int id) : _id = id;

  @override
  void initState() {
    productDatails = getProductDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: productDatails,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data as Widget;
          } else
            return Scaffold(
              body: Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
            );
        });
  }
}
