import 'package:flutter/material.dart';
import 'package:kcall_app/entities/weight_measurement.dart';
import 'package:kcall_app/helpers/db_helper.dart';
import 'package:path/path.dart';

class WeightStatistics extends StatefulWidget {
  @override
  WeightStatisticsState createState() => WeightStatisticsState();
}

class WeightStatisticsState extends State {
  late Future<Widget> weightMeasurements;

  Future<Widget> showWeightMeasurements() async {
    List<WeightMeasuerement> weightMeasurements =
        await DBHelper.getAllWeightMeasurements();
    return ListView.builder(
      itemCount: weightMeasurements.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text("${weightMeasurements[index].weightInKg.toString()} kg"),
          subtitle: Text(weightMeasurements[index].date),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    weightMeasurements = showWeightMeasurements();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pomiary wagi"),
      ),
      body: FutureBuilder(
          future: weightMeasurements,
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
