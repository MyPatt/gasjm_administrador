import 'dart:io';

import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/data/models/persona_model.dart';

abstract class PersonaRepository {
  DateTime get fechaHoraActual;
  String get idUsuarioActual;
  String get nombreUsuarioActual;

  Future<void> insertPersona({required PersonaModel persona});
  Future<void> updatePersona({required PersonaModel persona, File? image});
  Future<void> updateEstadoPersona(
      {required String uid, required String estado});
  Future<void> deletePersona({required String uid});
  Future<PersonaModel?> getDatosPersonaPorCedula({required String cedula});
  Future<String?> getNombresPersonaPorUid({required String uid});
  Future<List<PersonaModel>> getPersonasPorField(
      {required String field, required String dato});
  Future<String?> getDatoPersonaPorField(
      {required String field, required String dato, required String getField});

  Future<List<PersonaModel>> getPersonas();
  Future<PersonaModel?> getUsuario();
  Future<String?> getImagenUsuarioActual();
  Future<int> getCantidadClientesPorfield(
      {required String field, required String dato});
//
  Future<bool> updateContrasenaPersona(
      {required String uid,
      required String actualContrasena,
      required String nuevaContrasena});

  //
  Future<void> updateUbicacionActualDelUsuario(
      {required Direccion ubicacionActual, required double rotacionActual});
}
