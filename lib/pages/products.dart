import 'package:flutter/material.dart';
import 'package:kcall_app/entities/product.dart';
import 'package:kcall_app/helpers/db_helper.dart';
import 'package:kcall_app/pages/product_details.dart';

class ProductsList extends StatefulWidget {
  int _id;
  ProductsList(int id) : _id = id;

  @override
  _ProductsListState createState() => _ProductsListState(_id);
}

class _ProductsListState extends State<ProductsList> {
  int _id;
  late Future<Widget> productsList;

  Future<Widget> getProductsList(int id) async {
    List<Product> products = await DBHelper.getAllProductsFromCategory(id);
    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          print(products[index].id);

          return ListTile(
            title: Text(products[index].name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowProductDetails(products[index].id),
                ),
              );
            },
          );
        });
  }

  _ProductsListState(int id) : _id = id;

  @override
  void initState() {
    productsList = getProductsList(_id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista produktów"),
      ),
      body: FutureBuilder(
          future: productsList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data as Widget;
            } else {
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
