import 'package:flutter/material.dart';

class UserSettings extends StatelessWidget {
  late String _title;

  UserSettings({required isUserRegistered}) {
    if (isUserRegistered) {
      _title = "Stwórz konto";
    } else {
      _title = "Edytuj swoje konto";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Text("Imie : "),
              Flexible(child: TextFormField()),
            ],
          ),
          Row(
            children: [
              Text("Waga [kg] : "),
              Flexible(child: TextFormField()),
            ],
          ),
          Row(
            children: [
              Text("Płeć"),
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: null,
                child: const Text("Zapisz"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
