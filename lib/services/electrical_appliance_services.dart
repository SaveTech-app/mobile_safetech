import '../domain/models/electrical_appliance.dart';
import 'http_helper.dart';

class ElectricalApplianceService {
  final HttpHelper httpHelper;
  static const String endpoint = 'electricalAppliances';

  ElectricalApplianceService() : httpHelper = HttpHelper();

  Future<ElectricalAppliance> createElectricalAppliance(
      ElectricalAppliance electricalAppliance) async {
    final json = electricalAppliance.toJson();

    try {
      final createdJson = await httpHelper.post(endpoint, json);
      return ElectricalAppliance.fromJson(createdJson);
    } catch (e) {
      throw Exception('Error al crear el electrodomestico: $e');
    }
  }

  Future<List<ElectricalAppliance>> getAllElectricalAppliances() async {
    try {
      final jsonList = await httpHelper.get(endpoint);
      final List<dynamic> electricalAppliancesJson = jsonList as List<dynamic>;

      return electricalAppliancesJson
          .map((json) => ElectricalAppliance.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Error al obtener los electrodomesticos: $e');
    }
  }

  Future<ElectricalAppliance> getElectricalAppliance(String id) async {
    try {
      final json = await httpHelper.get('$endpoint/$id');
      return ElectricalAppliance.fromJson(json);
    } catch (e) {
      throw Exception('Error al obtener el electrodomestico: $e');
    }
  }

  Future<ElectricalAppliance> updateElectricalAppliance(
      ElectricalAppliance electricalAppliance) async {
    final json = electricalAppliance.toJson();

    try {
      final updatedJson =
          await httpHelper.put('$endpoint/${electricalAppliance.id}', json);
      return ElectricalAppliance.fromJson(updatedJson);
    } catch (e) {
      throw Exception('Error al actualizar el electrodomestico: $e');
    }
  }

  Future<void> deleteElectricalAppliance(String id) async {
    try {
      await httpHelper.delete('$endpoint/$id');
    } catch (e) {
      throw Exception('Error al eliminar el electrodomestico: $e');
    }
  }
}
