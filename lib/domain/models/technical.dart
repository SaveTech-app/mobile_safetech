// To parse this JSON data, do
//
//     final technical = technicalFromJson(jsonString);

class Technical {
  final String id;
  final String name;
  final String email;
  final String urlImage;
  final String information;
  final String experience;

  Technical({
    required this.id,
    required this.name,
    required this.email,
    required this.urlImage,
    required this.information,
    required this.experience,
  });

  factory Technical.fromJson(Map<String, dynamic> json) => Technical(
        id: json["id"] ?? "id",
        name: json["name"] ?? "name",
        email: json["email"] ?? "email",
        urlImage: json["urlImage"] ?? "urlImage",
        information: json["information"] ?? "information",
        experience: json["experience"] ?? "experience",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "urlImage": urlImage,
        "information": information,
        "experience": experience,
      };
}
