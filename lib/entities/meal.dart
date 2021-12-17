import 'package:intl/intl.dart';

class Meal {
  late int _amount;
  late int _productId;
  late String _date;

  Meal(int amount, int productId) {
    _amount = amount;
    _productId = productId;
    var now = DateTime.now();
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    _date = dateFormat.format(now).toString();
    print(_date);
  }

  Map<String, dynamic> toMap() {
    return {"idProduct": _productId, "amount": _amount, "date": _date};
  }

  Meal.fromMap(Map<String, dynamic> map) {
    _amount = map["amount"];
    _date = map["date"];
    _productId = map["id"];
  }
}
