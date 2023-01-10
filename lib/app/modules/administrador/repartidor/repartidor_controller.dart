
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/utils/mensajes.dart';
import 'package:gasjm/app/data/controllers/autenticacion_controller.dart';
import 'package:gasjm/app/data/models/categoria_model.dart';
import 'package:gasjm/app/data/models/persona_model.dart';
import 'package:gasjm/app/data/repository/persona_repository.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';

class RepartidorController extends GetxController {
  late CategoriaModelo _categoria;
  CategoriaModelo get house => _categoria;

  final _personaRepository = Get.find<PersonaRepository>();

  final cargandoListaRepartidores = true.obs;

//Listas observables de los clientes

  final RxList<PersonaModel> _listaRepartidores = <PersonaModel>[].obs;
  RxList<PersonaModel> get listaRepartidores => _listaRepartidores;

  //
  RxString imagenPerfil = Get.find<AutenticacionController>().imagenUsuario;
  /* METODOS PROPIOS */
  @override
  void onInit() {
    // _categoria = Get.arguments as CategoryModel;
    _cargarListaDeRepartidores();

    super.onInit();
  }

  /* METODOS */

  void _cargarListaDeRepartidores() async {
    try {
      cargandoListaRepartidores.value = true;

      final lista = (await _personaRepository.getPersonasPorField(
          field: 'idPerfil', dato: 'repartidor'));

      _listaRepartidores.value = lista;
      //
    } catch (e) {
      //
    }
    cargandoListaRepartidores.value = false;
  }

  Future<void> verDetalleDelRepartidor(PersonaModel cliente) async {
    await Future.delayed(const Duration(seconds: 1));
    Get.toNamed(AppRoutes.detalleCliente, arguments: [cliente, false]);
  }

  Future<void> editarDetalleDelRepartidor(PersonaModel cliente) async {
    await Future.delayed(const Duration(seconds: 1));
    Get.toNamed(AppRoutes.detalleCliente, arguments: [cliente, true]);
  }

  //Actualizar lista de repartidores
  Future<void> pullRefrescar() async {
    _cargarListaDeRepartidores();
    await Future.delayed(const Duration(seconds: 2));
  }

  //

  Future<void> eliminarRepartidor(String id) async {
    try {
      await _personaRepository.updateEstadoPersona(
          uid: id, estado: "eliminado");

      //
      Mensajes.showGetSnackbar(
          titulo: "Mensaje",
          mensaje: "Cliente eliminado con éxito.",
          icono: const Icon(
            Icons.delete_outline_outlined,
            color: Colors.white,
          ));

//Volver a actualizar la lista de clientes activos desde firestore
      _cargarListaDeRepartidores();
    } catch (e) {
      //
    }
  }
}
