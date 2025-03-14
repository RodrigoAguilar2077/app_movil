import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Obtener usuario por correo y contraseña
  Future<QuerySnapshot> getUsuario(String correo, String contrasena) {
    return _db
        .collection('usuarios')
        .where('correo', isEqualTo: correo)
        .where('contraseña', isEqualTo: contrasena)
        .get();
  }

  // Otros métodos, si los necesitas
  Future<void> agregarUsuario(Map<String, dynamic> usuario) async {
    await _db.collection('usuarios').add(usuario);
  }
}
