class SignUpModel {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? email;
  String? firstName;
  String? lastName;
  String? role;

  SignUpModel(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.email,
      this.firstName,
      this.lastName,
      this.role});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['role'] = role;
    return data;
  }
}
