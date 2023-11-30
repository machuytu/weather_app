class CategoriesModel {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? name;
  bool? choose;

  CategoriesModel(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.choose = false});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    name = json['name'];
    choose = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['name'] = name;
    data['choose'] = choose;
    return data;
  }
}
