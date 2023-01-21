import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/utils/mensajes.dart';
import 'package:gasjm/app/data/models/gasjm_model.dart';
import 'package:gasjm/app/data/models/horario_model.dart';
import 'package:gasjm/app/data/models/producto_model.dart';
import 'package:gasjm/app/data/repository/horario_repository.dart';
import 'package:url_launcher/url_launcher.dart';
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
  final actualizandoDistribuidora = RxBool(false);

  //se envia el modo para cargar la lista de los pedidos el administrador carga de todos
  //y el repartidor solo los correspondientes y al actualizar se cargan de nuevo la lista
  //refactorizado el codigo actualizar para usar por el administrador y repartidor
  // 0 administrador
  // 1 repartidor
  int modo = Get.arguments;

  //Variables para el tabarview Informacion
  Rx<GasJm> gasJM = GasJm().obs;
  Rx<ProductoModel> productoModel =
      const ProductoModel(nombreProducto: '', precioProducto: 0.0).obs;
//Clave del formulario para actualizar
  final claveFormActualizar = GlobalKey<FormState>();
  //
  final celularTextoController = TextEditingController();
  final precioTextoController = TextEditingController();
  //aMETODSO PROPIOS
  @override
  void onInit() {
    super.onInit();
    //
    cargarDatos();
    cargarDatosHorarios();
  }

  @override
  void onClose() {
    super.onClose();
    //
    celularTextoController.dispose();
    precioTextoController.dispose();
  }

  ///
  void cargarDatos() {
    cargarInformacionDistribuidora();
    cargarInformacionProducto();
  }

//Obtner informacion de la distribuidora y del producto desde firestore
  Future<void> cargarInformacionDistribuidora() async {
    try {
      // print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');

      gasJM.value = await _gasJMRepository.getInformacionDistribuidora();
      //asignar los valores al form de editar
      celularTextoController.text = gasJM.value.whatsappGasJm ?? '';
      // print(gasJM.value.whatsappGasJm);
      //} on FirebaseException catch (e) {
      //   print("oooooooooooooooooooooo");
      //  print(e.message);
    } catch (e) {
      Exception(
          'Ha ocurrido un error, por favor inténtelo de nuevo más tarde.');
    }
  }

//Obtner informacion de la distribuidora y del producto desde firestore
  Future<void> cargarInformacionProducto() async {
    try {
      productoModel.value = await _gasJMRepository.getProducto();
      //asignar los valores al form de editar

      precioTextoController.text = '${productoModel.value.precioProducto}';
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
      Future.delayed(const Duration(seconds: 1));
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

  //En modo admin se puede aditar el numero de celular para whatsap
  Future<void> actualizarCelular() async {
    try {
      actualizandoDistribuidora.value = true;
      //
      Future.delayed(const Duration(seconds: 1));
      //
      await _gasJMRepository.updateDatosDistribuidora(
          field: 'whatsappGasJm', dato: celularTextoController.text);
      //
      Mensajes.showGetSnackbar(
          titulo: "Mensaje",
          mensaje: "Número de celular actualizado con éxito.",
          icono: const Icon(
            Icons.check_circle_outlined,
            color: Colors.white,
          ));
      //
      cargarInformacionDistribuidora();
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
    actualizandoDistribuidora.value = false;
  }

  //En modo admin se puede aditar el precio del gas
  Future<void> actualizarPrecioProducto() async {
    try {
      actualizandoDistribuidora.value = true;
      //
      Future.delayed(const Duration(seconds: 1));
      //
      await _gasJMRepository.updateDatosProducto(
          field: 'precioProducto',
          dato: double.parse(precioTextoController.text));
      //
      Mensajes.showGetSnackbar(
          titulo: "Mensaje",
          mensaje: "Precio del producto actualizado con éxito.",
          icono: const Icon(
            Icons.check_circle_outlined,
            color: Colors.white,
          ));
      //
      cargarInformacionProducto();
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
    actualizandoDistribuidora.value = false;
  }

  //
  abrirChatWhatsapp() async {
    var contact = "+593${gasJM.value.whatsappGasJm}";
    var androidUrl = "whatsapp://send?phone=$contact&text=Hola ";
    var iosUrl = "https://wa.me/$contact?text=${Uri.parse('Hola ')}";

    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else {
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception {
      Mensajes.showGetSnackbar(
          titulo: 'Alerta',
          mensaje:
              'Ha ocurrido un error, por favor inténtelo de nuevo más tarde.',
          icono: const Icon(
            Icons.error_outline_outlined,
            color: Colors.white,
          ));
    }
  }
}
