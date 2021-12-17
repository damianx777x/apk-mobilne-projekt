import 'package:flutter/material.dart';
import 'package:kcall_app/entities/meal.dart';
import 'package:kcall_app/helpers/db_helper.dart';

class AddMeal_Amount extends StatefulWidget {
  late int _id;
  
  AddMeal_Amount(int id) {
    _id = id;
  }

  @override
  AddMeal_AmountState createState() => AddMeal_AmountState(_id);
}

class AddMeal_AmountState extends State {
  late int _id;
  TextEditingController controller = TextEditingController();
  AddMeal_AmountState(int id) {
    _id = id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Podaj wagę posiłku"),
      ),
      body: Column(
        children: [
          Row(
            children: [Text("Waga posiłku: ")],
          ),
          Row(
            children: [
              Flexible(
                  child: TextFormField(
                    controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: "Waga posiłku w gramach"),
              ))
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Meal mealToInsert = Meal(int.parse(controller.text), _id);
                  DBHelper.insertMeal(mealToInsert);
                },
                child: Text("Zapisz"),
              )
            ],
          )
        ],
      ),
    );
  }
}
