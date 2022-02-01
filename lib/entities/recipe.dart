class Recipe {
  String? name;
  String? description;
  String? photoPath;
  int? id;

  Recipe({required this.name, this.description, this.photoPath});

  Recipe.fromMap(Map<String, dynamic> map) {
    name = map["name"];
    description = map["description"];
    id = map["id"];
    photoPath = map["photoPath"];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "description": description,
      "photoPath" : photoPath
    };
  }
}
