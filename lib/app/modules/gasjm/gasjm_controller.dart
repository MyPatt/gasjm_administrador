import 'package:flutter/material.dart';
import 'package:gasjm/app/core/utils/mensajes.dart';
import 'package:gasjm/app/data/models/gasjm_model.dart';
import 'package:gasjm/app/data/models/horario_model.dart';
import 'package:gasjm/app/data/models/producto_model.dart';
import 'package:gasjm/app/data/repository/horario_repository.dart';
import 'package:get/get.dart';

class GasJMController extends GetxController {
  //Repositorio de horario
  final _gasJMRepository = Get.find<GasJMRepository>();

  /* Variables para obtener datos del horario*/
  final RxList<HorarioModel> _lista = <HorarioModel>[].obs;

  final horaAperturaTextController = TextEditingController();
  final horaCierreTextController = TextEditingController();
  RxList<HorarioModel> get listaHorarios => _lista;
  // //Mientras se inserta el pedido mostrar circuleprobres se carga si o no
  final actualizandoHorario = RxBool(false);

  //se envia el modo para cargar la lista de los pedidos el administrador carga de todos
  //y el repartidor solo los correspondientes y al actualizar se cargan de nuevo la lista
  //refactorizado el codigo actualizar para usar por el administrador y repartidor
  // 0 administrador
  // 1 repartidor
  int modo = Get.arguments;

  //Variables para el tabarview Informacion
  GasJm gasJM=GasJm();
  ProductoModel productoModel=const ProductoModel(nombreProducto: '', precioProducto: 0.0);
  //aMETODSO PROPIOS
  @override
  void onInit() {
    super.onInit();
    //
    //cargarDatos();
    cargarDatosHorarios();
  }

  cargarDatos()   {
    cargarInformacionDistribuidora();
    cargarInformacionProducto();
    
  }

//Obtner informacion de la distribuidora y del producto desde firestore
  Future<void> cargarInformacionDistribuidora() async {
    try {
      gasJM = await _gasJMRepository.getInformacionDistribuidora();
    } catch (e) {
      Exception(
          'Ha ocurrido un error, por favor inténtelo de nuevo más tarde.');
    }
  }

//Obtner informacion de la distribuidora y del producto desde firestore
  Future<void> cargarInformacionProducto() async {
    try {
      productoModel = await _gasJMRepository.getProducto();
    } catch (e) {
      Exception(
          'Ha ocurrido un error, por favor inténtelo de nuevo más tarde.');
    }
  }

//Obtner datos de los horarios desde firestore
  Future<void> cargarDatosHorarios() async {
    try {
      _lista.value = await _gasJMRepository.getListaHorarios();
    } catch (e) {
      Exception(
          'Ha ocurrido un error, por favor inténtelo de nuevo más tarde.');
    }
  }

//En modo admin se puede aditar el horario
  Future<void> actualizarHorario(HorarioModel horario) async {
    try {
      actualizandoHorario.value = true;
      //
      await _gasJMRepository.updateHorario(
          uidHorario: horario.uidHorario,
          horaApertura: horario.aperturaHorario,
          horaCierre: horario.cierreHorario);
      //
      Mensajes.showGetSnackbar(
          titulo: "Mensaje",
          mensaje: "Horario actualizado con éxito.",
          icono: const Icon(
            Icons.check_circle_outlined,
            color: Colors.white,
          ));
    } catch (e) {
      Mensajes.showGetSnackbar(
          titulo: 'Alerta',
          mensaje:
              'Ha ocurrido un error, por favor inténtelo de nuevo más tarde.',
          icono: const Icon(
            Icons.error_outline_outlined,
            color: Colors.white,
          ));
    }
    actualizandoHorario.value = false;
  }
}
