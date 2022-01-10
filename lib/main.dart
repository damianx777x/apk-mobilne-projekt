import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kcall_app/entities/meal.dart';
import 'package:kcall_app/entities/meal_to_display.dart';
import 'package:kcall_app/entities/weight_measurement.dart';
import 'package:kcall_app/helpers/db_helper.dart';
import 'package:kcall_app/pages/account_settings.dart';
import 'package:kcall_app/pages/add_meal_category.dart';
import 'package:kcall_app/widgets/drawer.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(KcallApp());

class KcallApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

//main page contains informations about current day calorie consumption
class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State {
  TextEditingController textEditingController = TextEditingController();

  Future<Widget> getPageContent() async {
    int kcallTarget = 2000;
    int proteinTarger = 150;
    int fatTarget = 80;
    int carbsTarget = 240;

    int kcall = 0;
    int fat = 0;
    int protein = 0;
    int carbs = 0;

    double kcallIndicate;
    double proteinIndicate;
    double fatIndicate;
    double carbsIndicate;

    DateTime dateTime = DateTime.now();
    DateFormat dateFromat = DateFormat("yyyy-MM-dd");
    print(dateFromat.format(dateTime).toString());
    List<MealToDisplay> meals =
        await DBHelper.getMealsFromDay(dateFromat.format(dateTime).toString());
    for (MealToDisplay m in meals) {
      kcall += m.kcall;
      fat += m.fat;
      protein += m.protein;
      carbs += m.carbs;
    }
    proteinIndicate = protein / proteinTarger;
    fatIndicate = fat / fatTarget;
    carbsIndicate = carbs / carbsTarget;
    kcallIndicate = kcall / kcallTarget;

    return ListView(
      children: [
        Text(
            "Witaj, dzisiaj jest ${DateTime.now().toString()} Twój docelowy bilans kaloryczny na dziś wynosi "),
        Row(
          children: [Text("Kcall: $kcall/$kcallTarget")],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        Container(
          child: LinearProgressIndicator(
            color: Colors.green.shade700,
            backgroundColor: Colors.green.shade200,
            value: kcallIndicate,
            minHeight: 8,
          ),
          padding: EdgeInsets.only(
            top: 8,
            left: 3,
            right: 3,
            bottom: 8,
          ),
        ),
        Row(
          children: [Text("Białko: $protein/$proteinTarger")],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        Container(
          child: LinearProgressIndicator(
            color: Colors.red.shade700,
            backgroundColor: Colors.red.shade200,
            minHeight: 8,
            value: proteinIndicate,
          ),
          padding: EdgeInsets.only(
            top: 8,
            left: 3,
            right: 3,
            bottom: 8,
          ),
        ),
        Row(
          children: [Text("Węglowodany: $carbs/$carbsTarget")],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        Container(
          child: LinearProgressIndicator(
            color: Colors.blue.shade700,
            backgroundColor: Colors.blue.shade200,
            value: carbsIndicate,
            minHeight: 8,
          ),
          padding: EdgeInsets.only(
            top: 8,
            left: 3,
            right: 3,
            bottom: 8,
          ),
        ),
        Row(
          children: [Text("Tłuszcz: $fat/$fatTarget")],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        Container(
          child: LinearProgressIndicator(
            color: Colors.yellow.shade700,
            backgroundColor: Colors.yellow.shade200,
            value: fatIndicate,
            minHeight: 8,
          ),
          padding: EdgeInsets.only(
            top: 8,
            left: 3,
            right: 3,
            bottom: 8,
          ),
        ),
        ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: meals.length,
            itemBuilder: (context, index) {
              print("sdds");
              return ListTile(
                title: Text(
                    "${meals[index].name} ${meals[index].amount} g ${meals[index].kcall} kcall"),
                subtitle: Text(
                    "Węglowodany: ${meals[index].carbs} g Białko:  ${meals[index].protein} g Tłuszcz: ${meals[index].fat} g"),
              );
            })
      ],
    );
  }

  late Future<Widget> widgets;
  late Future<Widget> content;

  @override
  void initState() {
    super.initState();
    content = checkIfUserRegistered();
    widgets = getPageContent();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: content,
      builder: (context, snapshot) {
        if (snapshot.hasData)
          return snapshot.data as Widget;
        else
          return Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
      },
    );
  }

  Future<Widget> checkIfUserRegistered() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getBool("registered") == null) {
      return UserSettings(isUserRegistered: false);
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Kcall App"),
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: this.context,
                  barrierDismissible: true,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Pomiar wagi"),
                      content: Form(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Waga w kg",
                          ),
                          controller: textEditingController,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            DBHelper.insertWeightMeasurement(
                              WeightMeasuerement(
                                double.parse(textEditingController.text),
                              ),
                            );
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          child: Text("Zapisz"),
                        )
                      ],
                    );
                  },
                );
              },
              icon: Icon(
                Icons.monitor_weight_outlined,
              ),
            )
          ],
        ),
        drawer: MyDrawer(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              this.context,
              MaterialPageRoute(
                builder: (context) => AddMeal_Category(),
              ),
            );
          },
        ),
        body: FutureBuilder(
          future: widgets,
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return snapshot.data as Widget;
            else
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
          },
        ),
      );
    }
  }
}
