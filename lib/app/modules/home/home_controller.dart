import 'package:flutter/material.dart';
import 'package:gasjm/app/data/models/category_model.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool _isLoading = true.obs;
  RxBool get isLoading => _isLoading;

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
}
