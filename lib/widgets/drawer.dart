import 'package:flutter/material.dart';
import 'package:kcall_app/pages/account_settings.dart';
import 'package:kcall_app/pages/diet_statistics.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text("Kcall App"),
          ),
          ListTile(
            title: Text("Spożycie kalorii"),
            subtitle: Text("Śledź swój dzienny bilans kaloryczny"),
            leading: Icon(Icons.food_bank),
          ),
          ListTile(
            title: Text("Baza produktów"),
            subtitle: Text("Przeglądaj bazę produktów spożywczych "),
            leading: Icon(Icons.fastfood_outlined),
          ),
          ListTile(
            title: Text("Baza przepisów"),
            subtitle: Text("Twórz oraz przeglądaj bazę przepisów"),
            leading: Icon(Icons.receipt),
          ),
          ListTile(
            title: Text("Moje konto"),
            subtitle: Text("Zarządzaj swoimi danymi"),
            leading: Icon(Icons.account_box),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserSettings(
                    isUserRegistered: true,
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: Text("Statystyki"),
            subtitle: Text("Przeglądaj statystyki diety"),
            leading: Icon(Icons.stacked_line_chart),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DietStatistics(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
