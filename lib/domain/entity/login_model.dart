class LoginModel {
  User? user;
  String? accessToken;
  String? refreshToken;

  LoginModel({this.user, this.accessToken, this.refreshToken});

  LoginModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    return data;
  }
}

class User {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? email;
  String? firstName;
  String? lastName;
  String? role;

  User(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.email,
      this.firstName,
      this.lastName,
      this.role});

  User.fromJson(Map<String, dynamic> json) {
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
