class ElectricalAppliance {
  final String id;
  final String name;
  final String urlImage;

  ElectricalAppliance({
    required this.id,
    required this.name,
    required this.urlImage,
  });

  factory ElectricalAppliance.fromJson(Map<String, dynamic> json) =>
      ElectricalAppliance(
        id: json["id"],
        name: json["name"],
        urlImage: json["urlImage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "urlImage": urlImage,
      };
}
