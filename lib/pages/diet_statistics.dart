import 'package:flutter/material.dart';
import 'package:kcall_app/pages/kcall_statistics.dart';
import 'package:kcall_app/pages/weight_statistics.dart';

class DietStatistics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Statystyki diety"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WeightStatistics(),
                    ),
                  );
                },
                child: Text("Zmiany wagi"),
              ),
              
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => KcallStatistics(),
                    ),
                  );
                },
                child: Text("Spożycie kcall"),
              ),
              
            ],
          ),
        ],
      ),
    );
  }
}
