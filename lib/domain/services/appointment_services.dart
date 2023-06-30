import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/appointment.dart';

class AppointmentServices {
  final CollectionReference _appointmentsCollection =
      FirebaseFirestore.instance.collection('appointments');

  Future<void> addAppointment(Appointment appointment) async {
    try {
      final DocumentReference docRef =
          await _appointmentsCollection.add(appointment.toJson());
      final String reportId = docRef.id;

      // Actualizar el objeto Report con el ID generado por Firebase
      appointment = Appointment(
        id: reportId,
        clientId: appointment.clientId,
        technicalId: appointment.technicalId,
        reportId: appointment.reportId,
        address: appointment.address,
        date: appointment.date,
      );

      // Actualizar el documento en Firebase con el ID incluido
      await docRef.set(appointment.toJson());
    } catch (error) {
      print("Error adding report: $error");
      throw Exception("Failed to add report");
    }
  }

  Future<Appointment> getAppointmentById(String appointmentId) async {
    try {
      final appointmentSnapshot =
          await _appointmentsCollection.doc(appointmentId).get();
      if (appointmentSnapshot.exists) {
        final appointmentData =
            appointmentSnapshot.data() as Map<String, dynamic>;
        final appointment = Appointment.fromJson(appointmentData);
        return appointment;
      } else {
        throw Exception('Appointment not found');
      }
    } catch (error) {
      print('Error getting appointment by ID: $error');
      throw Exception('Failed to get appointment by ID');
    }
  }

  Future<List<Appointment>> getAppointments() async {
    try {
      final QuerySnapshot snapshot = await _appointmentsCollection.get();
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String,
            dynamic>; // Asegurar el tipo de datos como Map<String, dynamic>
        return Appointment.fromJson(data);
      }).toList();
    } catch (error) {
      print("Error getting reports: $error");
      throw Exception("Failed to get reports");
    }
  }

  Future<void> updateAppointment(Appointment appointment) async {
    try {
      await _appointmentsCollection
          .doc(appointment.id)
          .update(appointment.toJson());
    } catch (error) {
      print('Error updating appointment: $error');
      throw Exception('Failed to update appointment');
    }
  }

  Future<void> deleteAppointment(String appointmentId) async {
    try {
      await _appointmentsCollection.doc(appointmentId).delete();
    } catch (error) {
      print('Error deleting appointment: $error');
      throw Exception('Failed to delete appointment');
    }
  }
}
