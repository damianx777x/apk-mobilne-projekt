import 'package:flutter/material.dart';
import 'package:kcall_app/entities/meal.dart';
import 'package:kcall_app/entities/meal_to_display.dart';
import 'package:kcall_app/helpers/db_helper.dart';
import 'package:kcall_app/widgets/drawer.dart';
import 'package:path/path.dart';

class KcallStatistics extends StatefulWidget {
  @override
  KcallStatisticsState createState() => KcallStatisticsState();
}

class KcallStatisticsState extends State<KcallStatistics> {
  Future<Widget?> getHistory() async {
    int kcallAll = 0;
    List<Map<String, dynamic>> kcallList = <Map<String, dynamic>>[];
    List<Map<String, dynamic>> dates = await DBHelper.getDates();
    for (Map<String, dynamic> date in dates) {
      print(date["date"]);
      List<MealToDisplay> meals = await DBHelper.getMealsFromDay(date["date"]);

      for (MealToDisplay md in meals) {
        kcallAll += md.kcall;
      }
      kcallList.add({"date": date["date"], "kcall": kcallAll});
      kcallAll = 0;
    }
    return ListView.builder(
        itemCount: kcallList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(kcallList[index]["date"]),
            subtitle: Text("${kcallList[index]["kcall"].toString()} kcall"),
          );
        });
  }

  late Future future;

  @override
  void initState() {
    future = getHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Historia spożycia kalorii"),
      ),
      drawer: MyDrawer(),
      body: FutureBuilder(future: future, builder: (context, snapshot) {
        if (snapshot.hasData)
          return snapshot.data as Widget;
        else
          return Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
      }),
    );
  }
}
