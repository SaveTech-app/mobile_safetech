import 'dart:developer';

import 'http_helper.dart';

import '../domain/models/report.dart';

class ReportService {
  final HttpHelper httpHelper;
  static const String endpoint = 'reports';

  ReportService() : httpHelper = HttpHelper();

  Future<Report> createReport(Report report) async {
    final json = report.toJson();

    try {
      final createdJson = await httpHelper.post(endpoint, json);
      return Report.fromJson(createdJson);
    } catch (e) {
      throw Exception('Error al crear el reporte: $e');
    }
  }

  Future<List<Report>> getAllReports() async {
    try {
      final jsonList = await httpHelper.get(endpoint);
      final List<dynamic> reportsJson = jsonList as List<dynamic>;

      return reportsJson.map((json) => Report.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error al obtener los reportes: $e');
    }
  }

  Future<Report> getReport(String id) async {
    try {
      final json = await httpHelper.get('$endpoint/$id');
      return Report.fromJson(json);
    } catch (e) {
      throw Exception('Error al obtener el reporte: $e');
    }
  }

  Future<Report> updateReport(Report report) async {
    final json = report.toJson();

    try {
      final updatedJson = await httpHelper.put('$endpoint/${report.id}', json);
      return Report.fromJson(updatedJson);
    } catch (e) {
      throw Exception('Error al actualizar el reporte: $e');
    }
  }

  Future<void> deleteReport(String id) async {
    try {
      await httpHelper.delete('$endpoint/$id');
    } catch (e) {
      throw Exception('Error al eliminar el reporte: $e');
    }
  }
}
