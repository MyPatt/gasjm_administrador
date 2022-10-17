import 'package:flutter/material.dart';
import 'package:gasjm/app/data/models/category_model.dart';
import 'package:gasjm/app/data/repository/persona_repository.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt isSelectedIndex = 0.obs;
  RxInt isSelectedIndexFecha = 0.obs;

  //
  Rx<DateTime> fechaInicial = DateTime.now().obs;
  RxString get selectedDate => (fechaInicial.value.day.toString() +
          '/' +
          fechaInicial.value.month.toString() +
          '/' +
          fechaInicial.value.year.toString())
      .obs;
//
  final _personaRepository = Get.find<PersonaRepository>();
  RxString imagenUsuario=''.obs;
  //
  /* METODOS PROPIOS */
  @override
  Future<void> onInit() async {
    super.onInit();
    Future.wait([_cargarFotoPerfil()]);
  }

  Future<void> _cargarFotoPerfil() async {
    imagenUsuario.value= await _personaRepository.getImagenUsuarioActual()??''; 
  }

//
  selectedIndex(int index) {
    isSelectedIndex.value = index;
  }

  selectedIndexFecha(int index) {
    isSelectedIndexFecha.value = index;
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? d = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      helpText: "Seleccione una fecha".toUpperCase(),
      cancelText: "Cancelar",
      confirmText: "Aceptar",
      initialDate: fechaInicial.value,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime.now(),
    );

    if (d != null) {
      fechaInicial.value = d;
      //
      print(selectedDate.value);
    } else {
      print(d.isBlank);
    }
  }

  void navegarDashboard() {
    switch (isSelectedIndex.value) {
      case 0:
        Get.toNamed(AppRoutes.detail,
            arguments: categories[isSelectedIndex.value]);
        break;
      case 1:
        Get.toNamed(AppRoutes.cliente,
            arguments: categories[isSelectedIndex.value]);
        break;
      default:
    }
  }
}
