class ProductCategory {
  late int _id;
  late String _name;

  ProductCategory(int id, String name) {
    _id = id;
    _name = name;
  }

  int get id {
    return _id;
  }

  String get name {
    return _name;
  }

  Map<String, dynamic> toMap() {
    return {"id": _id, "name": _name};
  }

  static fromMap(Map<String, dynamic> map) {
    return ProductCategory(map["id"], map["name"]);
  }
}
