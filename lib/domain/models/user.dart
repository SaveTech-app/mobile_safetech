class UserModel {
  final String id;
  final String type;
  final String email;
  final String password;

  UserModel({
    required this.id,
    required this.type,
    required this.email,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] ?? "",
        type: json["type"] ?? "",
        email: json["email"] ?? "",
        password: json["password"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "email": email,
        "password": password,
      };
}
