class SignUpResponseModel {
  String? email;
  String? password;
  String? name;
  String? avatar;
  String? role;
  int? id;
  String? creationAt;
  String? updatedAt;

  SignUpResponseModel(
      {this.email,
      this.password,
      this.name,
      this.avatar,
      this.role,
      this.id,
      this.creationAt,
      this.updatedAt});

  SignUpResponseModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    name = json['name'];
    avatar = json['avatar'];
    role = json['role'];
    id = json['id'];
    creationAt = json['creationAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['role'] = this.role;
    data['id'] = this.id;
    data['creationAt'] = this.creationAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
