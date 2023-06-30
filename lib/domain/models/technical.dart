class Technical {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String information;
  final String experience;

  Technical({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.information,
    required this.experience,
  });

  factory Technical.fromJson(Map<String, dynamic> json) => Technical(
        id: json["id"] ?? "id",
        firstName: json["firstName"] ?? "firstName",
        lastName: json["lastName"] ?? "lastName",
        email: json["email"] ?? "email",
        password: json["password"] ?? "password",
        information: json["information"] ?? "information",
        experience: json["experience"] ?? "experience",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "password": password,
        "email": email,
        "information": information,
        "experience": experience,
      };
}
