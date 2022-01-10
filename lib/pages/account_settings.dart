import 'package:flutter/material.dart';
import 'package:kcall_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Sex { male, female }
enum WeightTarget { lose, keep, gain }
enum ActivityLevel { veryLow, low, medium, high, veryHigh }

class UserSettings extends StatefulWidget {
  late bool accountCreation;

  UserSettings({required bool isUserRegistered}) {
    accountCreation = isUserRegistered;
  }

  @override
  State<UserSettings> createState() => _UserSettingsState(accountCreation);
}

class _UserSettingsState extends State<UserSettings> {
  _UserSettingsState(bool accountCreation) {
    this.accountCreation = accountCreation;
    if (accountCreation == true) {
      _title = "Utwórz konto";
    } else {
      _title = "Edytuj konto";
    }
  }
  late String _title;
  late bool accountCreation;
  String? name;
  double? weight;
  Sex? userSex;
  WeightTarget? userWeightTarget;
  ActivityLevel? userActivityLevel;
  int? age;
  bool accountExists = false;
  late Future<Widget> content;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    content = showContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: FutureBuilder(
          future: content,
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return snapshot.data as Widget;
            else {
              return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator());
            }
          },
        ));
  }

  Future<Widget> showContent() async {
    await readSettings();
    if (accountExists) {
      return InitializedMenu(
        age: age!,
        name: name!,
        sex: userSex!,
        weight: weight!,
        activityLevel: userActivityLevel!,
        weightTarget: userWeightTarget!,
      );
    } else {
      print("sdsd");
      return InitializedMenu.AccountCreation();
    }
  }

  readSettings() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getBool("registered") != null) {
      accountExists = true;
      name = sharedPreferences.getString("name")!;
      weight = sharedPreferences.getDouble("weight");
      age = sharedPreferences.getInt("age")!;
      userSex = Sex.values[sharedPreferences.getInt("sex")!];
      userWeightTarget =
          WeightTarget.values[sharedPreferences.getInt("goal")!];
      userActivityLevel =
          ActivityLevel.values[sharedPreferences.getInt("activity")!];
    }
  }
}

class InitializedMenu extends StatefulWidget {
  Sex? _userSex = Sex.male;
  ActivityLevel? _userActivitylevel = ActivityLevel.medium;
  WeightTarget? _userWeightTarget = WeightTarget.keep;
  bool accountCreated = false;
  int? age;
  String? name;
  double? weight;
  bool dataFromPreferences = false;


  InitializedMenu.AccountCreation() {}

  InitializedMenu(
      {required String name,
      required Sex sex,
      required int age,
      required double weight,
      required ActivityLevel activityLevel,
      required WeightTarget weightTarget}) {
    this.name = name;
    this.age = age;
    this._userActivitylevel = activityLevel;
    this._userSex = sex;
    this.weight = weight;
    this._userWeightTarget = weightTarget;
    dataFromPreferences = true;
  }

  InitializedMenuState createState() {
    if (dataFromPreferences) {
      return InitializedMenuState(
        name: name!,
        activityLevel: _userActivitylevel!,
        weight: weight!,
        age: age!,
        sex: _userSex!,
        weightTarget: _userWeightTarget!,
      );
    }
    else return InitializedMenuState.AccountCreation();
  }
}

class InitializedMenuState extends State {
  Sex? _userSex;
  ActivityLevel? _userActivitylevel;
  WeightTarget? _userWeightTarget;

  TextEditingController weightInputController = TextEditingController();
  TextEditingController ageInputController = TextEditingController();
  TextEditingController nameInputController = TextEditingController();

  InitializedMenuState(
      {required String name,
      required Sex sex,
      required int age,
      required double weight,
      required ActivityLevel activityLevel,
      required WeightTarget weightTarget}) {
    ageInputController.text = age.toString();
    nameInputController.text = name;
    weightInputController.text = weight.toString();
    _userActivitylevel = activityLevel;
    _userWeightTarget = weightTarget;
    _userSex = sex;
  }
  InitializedMenuState.AccountCreation() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            title: Text("Imie : "),
          ),
          Container(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: TextFormField(
              controller: nameInputController,
              keyboardType: TextInputType.name,
            ),
          ),
          ListTile(
            title: Text("Waga : "),
          ),
          Container(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: TextFormField(
              controller: weightInputController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
          ),
          ListTile(
            title: Text("Wiek : "),
          ),
          Container(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: TextFormField(
              controller: ageInputController,
              keyboardType: TextInputType.number,
            ),
          ),
          ListTile(
            title: Text("Płeć : "),
          ),
          RadioListTile(
              title: Text("Mężczyzna"),
              value: Sex.male,
              groupValue: _userSex,
              onChanged: (Sex? sex) {
                setState(() {
                  print("sds");
                  _userSex = sex;
                });
              }),
          RadioListTile(
              title: Text("Kobieta"),
              value: Sex.female,
              groupValue: _userSex,
              onChanged: (Sex? sex) {
                setState(() {
                  _userSex = sex;
                });
              }),
          ListTile(
            title: Text("Cel diety : "),
            subtitle: Text("Określ jaki jest cel Twojej diety"),
          ),
          RadioListTile<WeightTarget>(
              title: Text("Utrata wagi"),
              value: WeightTarget.lose,
              groupValue: _userWeightTarget,
              onChanged: (WeightTarget? value) {
                setState(() {
                  _userWeightTarget = value;
                });
              }),
          RadioListTile<WeightTarget>(
              title: Text("Utrzymanie obecnej wagi"),
              value: WeightTarget.keep,
              groupValue: _userWeightTarget,
              onChanged: (WeightTarget? value) {
                setState(() {
                  _userWeightTarget = value;
                });
              }),
          RadioListTile<WeightTarget>(
              title: Text("Budowa masy mięśniowej"),
              value: WeightTarget.gain,
              groupValue: _userWeightTarget,
              onChanged: (WeightTarget? value) {
                setState(() {
                  _userWeightTarget = value;
                });
              }),
          ListTile(
            title: Text("Poziom aktywności : "),
            subtitle: Text("Określ poziom swojej aktywności fizycznej "),
          ),
          RadioListTile<ActivityLevel>(
              value: ActivityLevel.veryLow,
              title: Text("Praca biurowa, brak aktywności sportowej"),
              groupValue: _userActivitylevel,
              onChanged: (ActivityLevel? value) {
                setState(() {
                  _userActivitylevel = value;
                });
              }),
          RadioListTile<ActivityLevel>(
              value: ActivityLevel.low,
              title: Text("Aktywność sportowa klika razy w miesiącu"),
              groupValue: _userActivitylevel,
              onChanged: (ActivityLevel? value) {
                setState(() {
                  _userActivitylevel = value;
                });
              }),
          RadioListTile<ActivityLevel>(
              value: ActivityLevel.medium,
              title: Text("1 -2 treningi w tygodniu"),
              groupValue: _userActivitylevel,
              onChanged: (ActivityLevel? value) {
                setState(() {
                  _userActivitylevel = value;
                });
              }),
          RadioListTile<ActivityLevel>(
              value: ActivityLevel.high,
              title: Text("Praca fizyczna lub trenign kilka razy w tygodniu"),
              groupValue: _userActivitylevel,
              onChanged: (ActivityLevel? value) {
                setState(() {
                  _userActivitylevel = value;
                });
              }),
          RadioListTile<ActivityLevel>(
              value: ActivityLevel.veryHigh,
              title: Text("Wyczynowe uprawianie sportu, codzienne traningi"),
              groupValue: _userActivitylevel,
              onChanged: (ActivityLevel? value) {
                setState(() {
                  _userActivitylevel = value;
                });
              }),
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: writeSettings,
                  child: Text("Zapisz"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  writeSettings() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("registered", true);
    sharedPreferences.setString("name", nameInputController.text);
    sharedPreferences.setDouble(
        "weight", double.parse(weightInputController.text));
    sharedPreferences.setInt("age", int.parse(ageInputController.text));
    sharedPreferences.setInt("goal", _userWeightTarget!.index);
    sharedPreferences.setInt("activity", _userActivitylevel!.index);
    sharedPreferences.setInt("sex", _userSex!.index);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MainPage()));
  }
}
