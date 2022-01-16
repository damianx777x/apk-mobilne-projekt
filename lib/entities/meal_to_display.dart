//class responsible for providing data structure for result of sql query
//class is used to generate list of meals in kcall tracker page

class MealToDisplay {
  late int _id;
  late int _kcall;
  late int _protein;
  late int _fat;
  late int _carbs;
  late int _amount;
  late String _name;
  late String _date;

  String get name {
    return _name;
  }

  int get kcall{
    return _kcall;
  }

  int get protein{
    return _protein;
  }

  int get  fat{
    return _fat;
  }

  int get carbs {
    return _carbs;
  }

  int get amount {
    return _amount;
  }

  int get id {
    return _id;
  }

  MealToDisplay.fromMap(Map<String, dynamic> map) {

    _amount = map["amount"]; 
    _id = map["id"];
    _kcall = (map["kcall"] * _amount / 100 as double).toInt();
    _name = map["name"];
    _fat = (map["fat"] * _amount / 100 as double).toInt();
    _protein = (map["protein"] * _amount / 100 as double).toInt();
    _carbs = (map["carbs"] * _amount / 100 as double).toInt();
    _date = map["date"];
  }
}