import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/client.dart';

class ClientServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _clientsCollection =
      FirebaseFirestore.instance.collection('clients');

  Future<Client> registerWithEmail(Client client) async {
    try {
      // Registra al cliente en Firebase Authentication
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: client.email,
        password: client.password,
      );
      final User user = userCredential.user!;

      // Crea un nuevo cliente en la base de datos
      final updatedClient = Client(
        id: user.uid,
        firstName: client.firstName,
        lastName: client.lastName,
        phoneNumber: client.phoneNumber,
        email: client.email,
        password: client.password,
      );
      await _clientsCollection.doc(user.uid).set(updatedClient.toJson());

      // Retorna el cliente registrado
      return updatedClient;
    } catch (error) {
      print("Error registering with email: $error");
      throw Exception("Failed to register with email");
    }
  }

  Future<Client> signInWithEmail(String email, String password) async {
    try {
      // Inicia sesión con correo electrónico y contraseña
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User user = userCredential.user!;

      // Obtiene los datos del cliente desde Firestore
      final DocumentSnapshot clientSnapshot =
          await _clientsCollection.doc(user.uid).get();
      if (clientSnapshot.exists) {
        final clientData = clientSnapshot.data() as Map<String, dynamic>;
        final client = Client.fromJson(clientData);
        return client;
      } else {
        throw Exception("Client not found");
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

  //! --------------------

  String getClientName() {
    return "Guess";
  }

  Future<Client> getClientById(String clientId) async {
    try {
      final DocumentSnapshot clientSnapshot =
          await _clientsCollection.doc(clientId).get();
      if (clientSnapshot.exists) {
        final clientData = clientSnapshot.data() as Map<String, dynamic>;
        final client = Client.fromJson(clientData);
        return client;
      } else {
        throw Exception("Client not found");
      }
    } catch (error) {
      print("Error getting client by ID: $error");
      throw Exception("Failed to get client by ID");
    }
  }

  Future<List<Client>> getClients() async {
    try {
      final QuerySnapshot snapshot = await _clientsCollection.get();
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String,
            dynamic>; // Asegurar el tipo de datos como Map<String, dynamic>
        return Client.fromJson(data);
      }).toList();
    } catch (error) {
      print("Error getting reports: $error");
      throw Exception("Failed to get reports");
    }
  }

  Future<void> updateClient(Client client) async {
    try {
      await _clientsCollection.doc(client.id).update(client.toJson());
    } catch (error) {
      print("Error updating client: $error");
      throw Exception("Failed to update client");
    }
  }

  Future<void> deleteClient(String clientId) async {
    try {
      await _clientsCollection.doc(clientId).delete();
    } catch (error) {
      print("Error deleting client: $error");
      throw Exception("Failed to delete client");
    }
  }
}
