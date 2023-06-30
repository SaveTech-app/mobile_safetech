import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/report.dart';

class ReportService {
  final CollectionReference reportsCollection =
      FirebaseFirestore.instance.collection('reports');

  Future<void> addReport(Report report) async {
    try {
      final DocumentReference docRef =
          await reportsCollection.add(report.toJson());
      final String reportId = docRef.id;

      // Actualizar el objeto Report con el ID generado por Firebase
      report = Report(
        id: reportId,
        clientId: report.clientId,
        electricalApplianceId: report.electricalApplianceId,
        title: report.title,
        description: report.description,
      );

      // Actualizar el documento en Firebase con el ID incluido
      await docRef.set(report.toJson());
    } catch (error) {
      print("Error adding report: $error");
      throw Exception("Failed to add report");
    }
  }

  Future<Report> getReportByUid(String reportId) async {
    try {
      final DocumentSnapshot snapshot =
          await reportsCollection.doc(reportId).get();
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        return Report.fromJson(data);
      } else {
        throw Exception("Report not found");
      }
    } catch (error) {
      print("Error getting report by UID: $error");
      throw Exception("Failed to get report by UID");
    }
  }

  Future<List<Report>> getReports() async {
    try {
      final QuerySnapshot snapshot = await reportsCollection.get();
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String,
            dynamic>; // Asegurar el tipo de datos como Map<String, dynamic>
        return Report.fromJson(data);
      }).toList();
    } catch (error) {
      print("Error getting reports: $error");
      throw Exception("Failed to get reports");
    }
  }

  Future<void> updateReport(Report report) async {
    try {
      await reportsCollection.doc(report.id).update(report.toJson());
    } catch (error) {
      print("Error updating report: $error");
      throw Exception("Failed to update report");
    }
  }

  Future<void> deleteReport(String reportId) async {
    try {
      await reportsCollection.doc(reportId).delete();
    } catch (error) {
      print("Error deleting report: $error");
      throw Exception("Failed to delete report");
    }
  }
}
