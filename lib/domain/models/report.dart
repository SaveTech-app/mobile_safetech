class Report {
  final String id;
  final String clientId;
  final String electricalApplianceId;
  final String title;
  final String description;

  Report({
    required this.id,
    required this.clientId,
    required this.electricalApplianceId,
    required this.title,
    required this.description,
  });

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        id: json["id"],
        clientId: json["clientId"],
        electricalApplianceId: json["electricalApplianceId"],
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "clientId": clientId,
        "electricalApplianceId": electricalApplianceId,
        "title": title,
        "description": description,
      };
}
