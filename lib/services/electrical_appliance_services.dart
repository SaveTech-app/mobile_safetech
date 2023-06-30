import 'package:cloud_firestore/cloud_firestore.dart';

import '../domain/models/electrical_appliance.dart';

class ElectricalApplianceService {
  final CollectionReference _appliancesCollection =
      FirebaseFirestore.instance.collection('electrical_appliances');

  Future<List<ElectricalAppliance>> getAppliances() async {
    try {
      final QuerySnapshot snapshot = await _appliancesCollection.get();
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String,
            dynamic>; // Asegurar el tipo de datos como Map<String, dynamic>
        return ElectricalAppliance.fromJson(data);
      }).toList();
    } catch (error) {
      print("Error getting appliances: $error");
      throw Exception("Failed to get appliances");
    }
  }

  Future<ElectricalAppliance> getApplianceById(String id) async {
    try {
      final DocumentSnapshot applianceSnapshot =
          await _appliancesCollection.doc(id).get();
      if (applianceSnapshot.exists) {
        final applianceData = applianceSnapshot.data() as Map<String, dynamic>;
        return ElectricalAppliance.fromJson(applianceData);
      } else {
        throw Exception("Appliance not found");
      }
    } catch (error) {
      print("Error getting appliance by ID: $error");
      throw Exception("Failed to get appliance by ID");
    }
  }

  Future<void> addAppliance(ElectricalAppliance appliance) async {
    try {
      await _appliancesCollection.add(appliance.toJson());
    } catch (error) {
      print("Error adding appliance: $error");
      throw Exception("Failed to add appliance");
    }
  }

  Future<void> updateAppliance(String id, ElectricalAppliance appliance) async {
    try {
      await _appliancesCollection.doc(id).update(appliance.toJson());
    } catch (error) {
      print("Error updating appliance: $error");
      throw Exception("Failed to update appliance");
    }
  }

  Future<void> deleteAppliance(String id) async {
    try {
      await _appliancesCollection.doc(id).delete();
    } catch (error) {
      print("Error deleting appliance: $error");
      throw Exception("Failed to delete appliance");
    }
  }
}
