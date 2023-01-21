import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/utils/map_style.dart';
import 'package:gasjm/app/core/utils/mensajes.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/data/repository/horario_repository.dart';
import 'package:gasjm/app/modules/gasjm/gasjm_controller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirecccionController extends GetxController {
  //Repositorio de horario
  final _gasJMRepository = Get.find<GasJMRepository>();

//Varaible que guarda el estado de cargar datos
  //Se cago si o no
  final cargandoDatos = RxBool(false);
  /* Variables para google maps */
  TextEditingController direccionAuxTextoController = TextEditingController();
  Direccion nuevaDireccionSeleccionada = Direccion(latitud: 0, longitud: 0);
/*
  final Rx<LatLng> _posicionInicialCliente =
      const LatLng(-12.122711, -77.027475).obs;

  Rx<LatLng> get posicionInicialCliente => _posicionInicialCliente.value.obs;*/
  final Rx<LatLng> _posicionAuxDistribuidora =
      const LatLng(-12.122711, -77.027475).obs;

  Rx<LatLng> get posicionAuxDistribuidora =>
      _posicionAuxDistribuidora.value.obs;

  //
  bool permisoParaEditarMapa = false;

  /* METODOS PROPIOS */

  @override
  void onInit() {
    Future.wait([obtenerDireccion()]);
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    //Limpiar campos
    direccionAuxTextoController.dispose();
  }

  /* METODOS PARA OBTENER DIRECCION */

  Future<void> obtenerDireccion() async {
    try {
      //obtener parametros
      //  1er parametro  => direccion
      //  2do parametro  => modo de edicion del mapa
      Direccion? direccionGasJm = Get.arguments[0];
      permisoParaEditarMapa = Get.arguments[1];
      //
      _posicionAuxDistribuidora.value = LatLng(
          direccionGasJm?.latitud ?? 0.0, direccionGasJm?.longitud ?? 0.0);
      //
      direccionAuxTextoController.text = await _getDireccionXLatLng(LatLng(
          direccionGasJm?.latitud ?? 0.0, direccionGasJm?.longitud ?? 0.0));
    } on FirebaseException {
      Mensajes.showGetSnackbar(
          titulo: "Error",
          mensaje: "Se produjo un error inesperado.",
          icono: const Icon(
            Icons.error_outline_outlined,
            color: Colors.white,
          ));
    }
  }

  //
  Future<String> _getDireccionXLatLng(LatLng posicion) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(posicion.latitude, posicion.longitude);
    Placemark lugar = placemark[0];

//
    return _getNombreDireccion(lugar);
  }

  String _getNombreDireccion(Placemark lugar) {
    //
    if (lugar.subLocality?.isEmpty == true) {
      return lugar.street.toString();
    } else {
      return '${lugar.street}, ${lugar.subLocality}';
    }
  }

  /* ACTUALIZAR DIRECCION - GOOGLE MAP*/

  void onMapaCreado(GoogleMapController controller) {
    controller.setMapStyle(estiloMapa);

    // _agregarMarcadorCliente();
    // notifyListeners();
  }

  void onCameraMove(CameraPosition position) async {
    _posicionAuxDistribuidora.value = position.target;
  }

  void getMovimientoCamara() async {
    List<Placemark> placemark = await placemarkFromCoordinates(
        _posicionAuxDistribuidora.value.latitude,
        _posicionAuxDistribuidora.value.longitude,
        localeIdentifier: "en_US");
    direccionAuxTextoController.text = placemark[0].name!;
  }

  void actualizarNuevaDireccion() {
    try {
      cargandoDatos.value = true;
       //
          Future.delayed(
                                              const Duration(seconds: 1));
      nuevaDireccionSeleccionada = Direccion(
          latitud: posicionAuxDistribuidora.value.latitude,
          longitud: posicionAuxDistribuidora.value.longitude);
//
      //print(nuevaDireccionSeleccionada.latitud);
      //Actualizar
      _gasJMRepository.updateDatosDistribuidora(
          field: 'direccionGasJm', dato: nuevaDireccionSeleccionada.toMap());
      _gasJMRepository.updateDatosDistribuidora(
          field: 'nombreLugar', dato: direccionAuxTextoController.text);
      //print(nuevaDireccionSeleccionada.longitud);

      //
      Mensajes.showGetSnackbar(
          titulo: 'Mensaje',
          mensaje: '¡Se guardo con éxito!',
          icono: const Icon(
            Icons.save_outlined,
            color: Colors.white,
          ));
      //
      Get.find<GasJMController>().cargarInformacionDistribuidora();
    } catch (e) {
      Mensajes.showGetSnackbar(
          titulo: 'Alerta',
          mensaje:
              'Ha ocurrido un error, por favor inténtelo de nuevo más tarde.',
          duracion: const Duration(seconds: 4),
          icono: const Icon(
            Icons.error_outline_outlined,
            color: Colors.white,
          ));
    }
      cargandoDatos.value = false;
  }
}
