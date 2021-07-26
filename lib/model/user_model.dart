class UserModel {
  UserModel({
    this.name,
    this.email,
    this.phone,
    this.role,
    this.token,
  });

  String name;
  String email;
  String phone;
  int role;
  String token;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        role: json["role"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "role": role,
        "token": token,
      };
}
