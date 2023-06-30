import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  final String id;
  final String clientId;
  final String technicalId;
  final String reportId;
  final String address;
  final Timestamp date;

  Appointment({
    required this.id,
    required this.clientId,
    required this.technicalId,
    required this.reportId,
    required this.address,
    required this.date,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'] ?? '',
      clientId: json['clientId'] ?? '',
      technicalId: json['technicalId'] ?? '',
      reportId: json['reportId'] ?? '',
      address: json['address'] ?? '',
      date: json['date'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clientId': clientId,
      'technicalId': technicalId,
      'reportId': reportId,
      'address': address,
      'date': date,
    };
  }
}
