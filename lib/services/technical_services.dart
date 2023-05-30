import 'http_helper.dart';

import '../domain/models/technical.dart';

class TechnicalService {
  final HttpHelper httpHelper;
  static const String endpoint =
      'technicals'; // Reemplaza con el endpoint correspondiente a los técnicos en tu API

  TechnicalService() : httpHelper = HttpHelper();

  Future<Technical> createTechnical(Technical technical) async {
    final json = technical.toJson();

    try {
      final createdJson = await httpHelper.post(endpoint, json);
      return Technical.fromJson(createdJson);
    } catch (e) {
      throw Exception('Error al crear el técnico: $e');
    }
  }

  Future<List<Technical>> getAllTechnicals() async {
    try {
      final jsonList = await httpHelper.get(endpoint);
      final List<dynamic> technicalsJson = jsonList as List<dynamic>;

      return technicalsJson.map((json) => Technical.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error al obtener los técnicos: $e');
    }
  }

  Future<Technical> getTechnical(String id) async {
    try {
      final json = await httpHelper.get('$endpoint/$id');
      return Technical.fromJson(json);
    } catch (e) {
      throw Exception('Error al obtener el técnico: $e');
    }
  }

  Future<Technical> updateTechnical(Technical technical) async {
    final json = technical.toJson();

    try {
      final updatedJson =
          await httpHelper.put('$endpoint/${technical.id}', json);
      return Technical.fromJson(updatedJson);
    } catch (e) {
      throw Exception('Error al actualizar el técnico: $e');
    }
  }

  Future<void> deleteTechnical(String id) async {
    try {
      await httpHelper.delete('$endpoint/$id');
    } catch (e) {
      throw Exception('Error al eliminar el técnico: $e');
    }
  }
}
