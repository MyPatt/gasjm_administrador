import 'dart:io';

import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/data/models/persona_model.dart';
import 'package:gasjm/app/data/providers/persona_provider.dart';
import 'package:gasjm/app/data/repository/persona_repository.dart';
import 'package:get/get.dart';

class PersonaRepositoryImpl extends PersonaRepository {
  final _provider = Get.find<PersonaProvider>();
  @override
  DateTime get fechaHoraActual => _provider.fechaHoraActual.toDate();

  @override
  String get idUsuarioActual => _provider.idUsuarioActual;
  @override
  String get nombreUsuarioActual => _provider.nombreUsuarioActual;

  @override
  Future<void> deletePersona({required String persona}) =>
      _provider.deletePersona(persona: persona);

  @override
  Future<PersonaModel?> getDatosPersonaPorCedula({required String cedula}) =>
      _provider.getPersonaPorCedula(cedula: cedula);

  @override
  Future<List<PersonaModel>> getPersonasPorField(
          {required String field, required String dato}) =>
      _provider.getPersonasPorField(field: field, dato: dato);

  @override
  Future<String?> getDatoPersonaPorField(
          {required String field,
          required String dato,
          required String getField}) =>
      _provider.getDatoPersonaPorField(
          field: field, dato: dato, getField: getField);

  @override
  Future<List<PersonaModel>> getPersonas() => _provider.getPersonas();

  @override
  Future<void> insertPersona({required PersonaModel persona}) =>
      _provider.insertPersona(persona: persona);

  @override
  Future<void> updatePersona({required PersonaModel persona, File? image}) =>
      _provider.updatePersona(persona: persona, image: image);

  @override
  Future<String?> getNombresPersonaPorUid({required String uid}) =>
      _provider.getNombresPersonaPorUid(uid: uid);

  @override
  Future<PersonaModel?> getUsuario() => _provider.getUsuarioActual();

  @override
  Future<String?> getImagenUsuarioActual() =>
      _provider.getImagenUsuarioActual();

  @override
  Future<void> updateEstadoPersona(
          {required String uid, required String estado}) =>
      _provider.updateEstadoPersona(uid: uid, estado: estado);

  @override
  Future<bool> updateContrasenaPersona(
          {required String uid,
          required String actualContrasena,
          required String nuevaContrasena}) =>
      _provider.updateContrasenaPersona(
          uid: uid,
          actualContrasena: actualContrasena,
          nuevaContrasena: nuevaContrasena);

  @override
  Future<int> getCantidadClientesPorfield(
          {required String field, required String dato}) =>
      _provider.getCantidadClientesPorfield(field: field, dato: dato);

  @override
  Future<void> updateUbicacionActualDelUsuario(
          {required Direccion ubicacionActual, required double rotacionActual}) =>
      _provider.updateUbicacionActualDelUsuario(
          ubicacionActual: ubicacionActual, rotacionActual: rotacionActual);
}
