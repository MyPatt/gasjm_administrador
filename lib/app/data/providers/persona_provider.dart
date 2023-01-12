import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gasjm/app/data/controllers/autenticacion_controller.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/data/models/persona_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;

class PersonaProvider {
  //Instancia de firestore
  final _firestoreInstance = FirebaseFirestore.instance;
  //Instancia de storage
  FirebaseStorage get _storageInstance => FirebaseStorage.instance;

  //Par devolver el usuario actual conectado
  User get usuarioActual {
    final usuario = FirebaseAuth.instance.currentUser;
    if (usuario == null) throw Exception('Excepción no autenticada');
    return usuario;
  }

//
  //
  Timestamp get fechaHoraActual => Timestamp.now();
  String get idUsuarioActual => usuarioActual.uid;
  String get nombreUsuarioActual => usuarioActual.displayName ?? 'usuario';
  //
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

    _firestoreInstance.collection("persona").doc(uid).update({"uid": uid});
  }

  //
  Future<void> updatePersona(
      {required PersonaModel persona, File? image}) async {
    await _firestoreInstance
        .collection('persona')
        .doc(persona.uidPersona)
        .update(persona.toMap());
    if (image != null) {
      final imagePath =
          '${usuarioActual.uid}/perfil/fotoperfil${path.extension(image.path)}';
      final storageRef = _storageInstance.ref(imagePath);
      await storageRef.putFile(image);
      final url = await storageRef.getDownloadURL();
      _firestoreInstance
          .collection("persona")
          .doc(usuarioActual.uid)
          .update({"foto": url});
      usuarioActual.updatePhotoURL(url);
    }
    //Actualizar nombre
    usuarioActual.updateDisplayName(
        '${persona.nombrePersona} ${persona.apellidoPersona}');

    // usuarioActual.updateEmail(persona.correoPersona.toString());
  }
//

  //
  Future<void> deletePersona({required String persona}) async {
    await _firestoreInstance.collection('persona').doc(persona).delete();
  }

  //
  Future<List<PersonaModel>> getPersonas() async {
    final snapshot = await _firestoreInstance.collection('persona').get();

    return (snapshot.docs)
        .map((item) => PersonaModel.fromMap(item.data()))
        .toList();
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

  Future<List<PersonaModel>> getPersonasPorField(
      {required String field, required String dato}) async {
    final resultado = await _firestoreInstance
        .collection("persona")
        .where("estado", isEqualTo: "activo")
        .where(field, isEqualTo: dato)
        .get();

    return (resultado.docs)
        .map((item) => PersonaModel.fromMap(item.data()))
        .toList();
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

  Future<String?> getNombresPersonaPorUid({required String uid}) async {
    final resultado =
        await _firestoreInstance.collection("persona").doc(uid).get();

    if (resultado.exists) {
      final nombres =
          '${resultado.get("nombre")} ${resultado.get("apellido")} ';
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

  Future<String?> getImagenUsuarioActual() async {
    final snapshot = await _firestoreInstance
        .collection('persona')
        .doc(usuarioActual.uid)
        .get();

    String? resultado = (snapshot.get("foto"));

    if (resultado != null) {
      return resultado;
    }
    return null;
  }

  updateEstadoPersona({required String uid, required String estado}) async {
    await _firestoreInstance
        .collection('persona')
        .doc(uid)
        .update({"estado": estado});
  }

  //Actualiza la contrasena del usuario
  Future<bool> updateContrasenaPersona(
      {required String uid,
      required String actualContrasena,
      required String nuevaContrasena}) async {
    bool actualizado = false;
    //

    final credencial = EmailAuthProvider.credential(
        email: usuarioActual.email.toString(), password: actualContrasena);
    await usuarioActual.reauthenticateWithCredential(credencial).then((value) {
      usuarioActual.updatePassword(nuevaContrasena).then((value) {
        actualizado = true;
      });
    });

    return actualizado;
  }

  //Retornar personas por field
  Future<List<PersonaModel>> getNombresPorField(
      {required String field, required String dato}) async {
    final resultado = await _firestoreInstance
        .collection("persona")
        .where("estado", isEqualTo: "activo")
        .where(field, isEqualTo: dato)
        .get();

   return (resultado.docs)
        .map((item) => PersonaModel.fromMap(item.data()))
        .toList();

 
  }

  //Retornar la cantidad de cleintes por field
  Future<int> getCantidadClientesPorfield(
      {required String field, required String dato}) async {
    final resultado = await _firestoreInstance
        .collection("persona")
        .where("estado", isEqualTo: "activo")
        .where(field, isEqualTo: dato)
        .get();

    return resultado.docs.length;
  }

  //Actualizar ubicacion del usuario actual conectado - repartidor
  Future<void> updateUbicacionActualDelUsuario(
      {required Direccion ubicacionActual,
      required double rotacionActual}) async {
    await _firestoreInstance
        .collection('ubicacionRepartidor')
        .doc(idUsuarioActual)
        .set({
      "ubicacionActual": ubicacionActual.toMap(),
      "rotacionActual": rotacionActual
    });
    //TODO: Revisar si funciona bien si se actualiza cuando no se a creado el doc
    //Realizar con update y al momento de crear el usuario crear el documento ubicacionRepartidor con el id

    /*
        (data)
    await _firestoreInstance
        .collection('ubicacionRepartidor')
        .doc(idUsuarioActual)
        .update
        */
  }
}
