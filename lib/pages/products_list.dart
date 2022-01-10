import 'package:flutter/material.dart';
import 'package:kcall_app/pages/define_new_product.dart';

class ProductsList extends StatefulWidget {
  @override
  ProductsListState createState() => ProductsListState();
}

class ProductsListState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista produktów"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddNewProduct()));
        },
      ),
    );
  }
}
