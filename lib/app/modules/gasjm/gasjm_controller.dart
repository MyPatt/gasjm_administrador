
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/utils/mensajes.dart';
import 'package:gasjm/app/data/models/horario_model.dart';
import 'package:gasjm/app/data/repository/horario_repository.dart';
import 'package:get/get.dart';

class GasJMController extends GetxController {
  //Repositorio de horario
  final _horarioRepository = Get.find<HorarioRepository>();

  /* Variables para obtener datos del horario*/
  final RxList<HorarioModel> _lista = <HorarioModel>[].obs;

  final horaAperturaTextController = TextEditingController();
  final horaCierreTextController = TextEditingController();
  RxList<HorarioModel> get listaHorarios => _lista;
  // //Mientras se inserta el pedido mostrar circuleprobres se carga si o no
  final actualizandoHorario = RxBool(false);

  //
  int modo = Get.arguments;
  //
  @override
  void onInit() {
    super.onInit();
    //
    cargarDatos();
  }

  Future<void> cargarDatos() async {
//
    try {
      _lista.value = await _horarioRepository.getListaHorarios();
    } catch (e) {
      //
    }
  }

  Future<void> actualizarHorario(HorarioModel horario) async {
    try {
      actualizandoHorario.value = true;
      //
      await _horarioRepository.updateHorario(
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
