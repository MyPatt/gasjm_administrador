import 'package:flutter/material.dart';
import 'package:gasjm/app/core/utils/mensajes.dart';
import 'package:gasjm/app/data/controllers/autenticacion_controller.dart';

import 'package:gasjm/app/data/models/vehiculo_model.dart';
import 'package:gasjm/app/data/repository/vehiculo_repository.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';

class OperacionVehiculoController extends GetxController {
////Variables
  final _vehiculoRepository = Get.find<VehiculoRepository>();

  final cargandoListaVehiculos = true.obs;

//Listas observables de los clientes

  final RxList<Vehiculo> _listaVehiculos = <Vehiculo>[].obs;
  RxList<Vehiculo> get listaVehiculos => _listaVehiculos;

  //Obtener imagen usuaior actual
  RxString imagenPerfil = Get.find<AutenticacionController>().imagenUsuario;
  /* METODOS PROPIOS */
  @override
  void onInit() {
    _cargarListaDeVehiculos();

    super.onInit();
  }

  /* METODOS */

  void _cargarListaDeVehiculos() async {
    try {
      cargandoListaVehiculos.value = true;

      final lista = await _vehiculoRepository.getVehiculos();

      _listaVehiculos.value = lista;
      //
    } catch (e) {
      //
    }
    cargandoListaVehiculos.value = false;
  }

  Future<void> verDatosVehiculo(Vehiculo vehiculo) async {
    await Future.delayed(const Duration(seconds: 1));
    Get.toNamed(AppRoutes.detalleVehiculo, arguments: [
      vehiculo,
      false,
    ]);
  }

  Future<void> editarDatosVehiculo(Vehiculo vehiculo) async {
    await Future.delayed(const Duration(seconds: 1));
    Get.toNamed(AppRoutes.detalleVehiculo, arguments: [
      vehiculo,
      true,
    ]);
  }

  //Actualizar lista de vehiculos
  Future<void> pullRefrescar() async {
    await Future.delayed(const Duration(seconds: 2));

    _cargarListaDeVehiculos();
  }

  //

  Future<void> eliminarVehiculo(String id) async {
    try {
      await _vehiculoRepository.deleteVehiculo(uid: id);

      //
      Mensajes.showGetSnackbar(
          titulo: "Mensaje",
          mensaje: "Vehículo eliminado con éxito.",
          icono: const Icon(
            Icons.delete_outline_outlined,
            color: Colors.white,
          ));

//Volver a actualizar la lista de clientes activos desde firestore
      _cargarListaDeVehiculos();
    }   catch (e) {
      //
      
    }
  }
}
