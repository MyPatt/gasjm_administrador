import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gasjm/app/data/controllers/autenticacion_controller.dart'; 
import 'package:gasjm/app/data/models/persona_model.dart'; 
import 'package:get/get.dart';

class PersonaProvider {
  //Instancia de firestore
  final _firestoreInstance = FirebaseFirestore.instance;

  //Par devolver el usuario actual conectado
  User get usuarioActual {
    final usuario = FirebaseAuth.instance.currentUser;
    if (usuario == null) throw Exception('Excepción no autenticada');
    return usuario;
  }

  Future<void> insertPersona({
    required PersonaModel persona,
  }) async {
    //InsertarRepartidor
    // //Ingresar datos de usuario
    final uid =
        Get.find<AutenticacionController>().autenticacionUsuario.value!.uid;

    await _firestoreInstance
        .collection("persona")
        .doc(uid)
        .set(persona.toMap());
  }

  //
  Future<void> updatePersona({required PersonaModel persona}) async {
    await _firestoreInstance
        .collection('persona')
        .doc(persona.cedulaPersona)
        .update(persona.toMap());
  }

  //
  Future<void> deletePersona({required String persona}) async {
    await _firestoreInstance.collection('persona').doc(persona).delete();
  }

  //
  Future<List<PersonaModel>?> getPersonas() async {
    final snapshot = await _firestoreInstance.collection('persona').get();

    if (snapshot.docs.isNotEmpty) {
      return (snapshot.docs)
          .map((item) => PersonaModel.fromMap(item.data()))
          .toList();
    }
    return null;
  }

  //
  Future<PersonaModel?> getPersonaPorCedula({required String cedula}) async {
    final snapshot = await _firestoreInstance
        .collection("persona")
        .where("cedula", isEqualTo: cedula)
        .get();
    if (snapshot.docs.isNotEmpty) {
      return PersonaModel.fromMap(snapshot.docs.first.data());
    }
    return null;
  }

  Future<List<PersonaModel>?> getPersonaPorField(
      {required String field, required String dato}) async {
    final resultado = await _firestoreInstance
        .collection("persona")
        .where(field, isEqualTo: dato)
        .get();
    if ((resultado.docs.isNotEmpty)) {
      return (resultado.docs)
          .map((item) => PersonaModel.fromMap(item.data()))
          .toList();
    }
    return null;
  }

//Retorna datos personales publicos de la persona
  Future<String?> getDatoPersonaPorField(
      {required String field,
      required String dato,
      required String getField}) async {
    final resultado = await _firestoreInstance
        .collection("persona")
        .where(field, isEqualTo: dato)
        .get();
    if ((resultado.docs.isNotEmpty)) {
      String dato = resultado.docs.first.get(getField).toString();
      return dato;
    }
    return null;
  }

  Future<String?> getNombresPersonaPorCedula({required String cedula}) async {
    final resultado = await _firestoreInstance
        .collection("persona")
        .where("cedula", isEqualTo: cedula)
        .get();

    if (resultado.docs.isNotEmpty) {
      final nombres =
          '${resultado.docs.first.get("nombre")} ${resultado.docs.first.get("apellido")} ';
      return nombres;
    }
    return null;
  }

  //Obtner datos del usuario actual
  Future<PersonaModel?> getUsuarioActual() async {
    final snapshot = await _firestoreInstance
        .collection('persona')
        .doc(usuarioActual.uid)
        .get();
    if (snapshot.exists) {
      return PersonaModel.fromMap(snapshot.data()!);
    }
    return null;
  }
}
