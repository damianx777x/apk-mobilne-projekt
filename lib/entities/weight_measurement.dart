import 'package:intl/intl.dart';

class WeightMeasuerement {

  late DateTime _date ;
  late double _weightInKg;

  WeightMeasuerement(double weightInKg) {
    _weightInKg = weightInKg;
    _date = DateTime.now();
  }

  double get weightInKg {
    return _weightInKg;
  }

  String get date {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    return dateFormat.format(_date).toString();
  }

  WeightMeasuerement.fromSql({required double weightInKg, required String date}) {
    _date = DateTime.parse(date);
    _weightInKg = weightInKg; 
  }

  Map<String,dynamic> toSqlMap() {
    String dateToInsert = "${_date.year}-${_date.month}-${_date.day}";
    return {
      "date" : dateToInsert,
      "weightInKg": _weightInKg
    };
  }




}