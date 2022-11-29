import 'package:flutter/cupertino.dart';
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

  @override
  void onInit() {
    super.onInit();
    //
    _cargarDatos();
  }

  Future<void> _cargarDatos() async {
//
    try {
      _lista.value = await _horarioRepository.getListaHorarios();
    } catch (e) {
      //
    }
  }

  actualizarHorario(HorarioModel horario) {}
}
