import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/technical.dart';

class TechnicalServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _technicalsCollection =
      FirebaseFirestore.instance.collection('technicals');

  Future<Technical> registerWithEmail(Technical technical) async {
    try {
      // Registra al técnico en Firebase Authentication
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: technical.email,
        password: technical.password,
      );
      final User user = userCredential.user!;

      // Crea un nuevo técnico en la base de datos
      final updatedTechnical = Technical(
        id: user.uid,
        firstName: technical.firstName,
        lastName: technical.lastName,
        email: technical.email,
        password: technical.password,
        information: technical.information,
        experience: technical.experience,
      );
      await _technicalsCollection.doc(user.uid).set(updatedTechnical.toJson());

      // Retorna el técnico registrado
      return updatedTechnical;
    } catch (error) {
      print("Error registering with email: $error");
      throw Exception("Failed to register with email");
    }
  }

  Future<Technical> signInWithEmail(String email, String password) async {
    try {
      // Inicia sesión con correo electrónico y contraseña
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User user = userCredential.user!;

      // Obtiene los datos del técnico desde Firestore
      final DocumentSnapshot technicalSnapshot =
          await _technicalsCollection.doc(user.uid).get();
      if (technicalSnapshot.exists) {
        final technicalData = technicalSnapshot.data() as Map<String, dynamic>;
        final technical = Technical.fromJson(technicalData);
        return technical;
      } else {
        throw Exception("Technical not found");
      }
    } catch (error) {
      print("Error signing in with email: $error");
      throw Exception("Failed to sign in with email");
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (error) {
      print("Error signing out: $error");
      throw Exception("Failed to sign out");
    }
  }

  String getTechnicalName() {
    return "Guess";
  }

  Future<Technical?> getTechnicalById(String technicalId) async {
    try {
      final DocumentSnapshot technicalSnapshot =
          await _technicalsCollection.doc(technicalId).get();
      if (technicalSnapshot.exists) {
        final technicalData = technicalSnapshot.data() as Map<String, dynamic>;
        final technical = Technical.fromJson(technicalData);
        return technical;
      } else {
        return null;
      }
    } catch (error) {
      print("Error getting technical by ID: $error");
      throw Exception("Failed to get technical by ID");
    }
  }

  Future<void> updateTechnical(Technical technical) async {
    try {
      await _technicalsCollection.doc(technical.id).update(technical.toJson());
    } catch (error) {
      print("Error updating technical: $error");
      throw Exception("Failed to update technical");
    }
  }

  Future<void> deleteTechnical(String technicalId) async {
    try {
      await _technicalsCollection.doc(technicalId).delete();
    } catch (error) {
      print("Error deleting technical: $error");
      throw Exception("Failed to delete technical");
    }
  }
}
