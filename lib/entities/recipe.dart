class Recipe {
  String? name;
  String? description;
  int? id;

  Recipe(this.id, this.name, this.description);

  Recipe.fromMap(Map<String, dynamic> map) {
  name = map["name"];
  description = map["description"];
  id = map["id"];
} 
}

