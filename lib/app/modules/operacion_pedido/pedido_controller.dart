import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/utils/mensajes.dart';
import 'package:gasjm/app/data/models/categoria_model.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/data/repository/pedido_repository.dart';
import 'package:gasjm/app/data/repository/persona_repository.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class OperacionPedidoController extends GetxController {
  final _pedidosRepository = Get.find<PedidoRepository>();
  final _personaRepository = Get.find<PersonaRepository>();
//
  RxString imagenUsuario = ''.obs;

  //Pedidos en espera

  final RxList<PedidoModel> _listaPedidosEnEspera = <PedidoModel>[].obs;
  RxList<PedidoModel> get listaPedidosEnEspera => _listaPedidosEnEspera;
  //Pedidos aceptados

  final RxList<PedidoModel> _listaPedidosAceptados = <PedidoModel>[].obs;
  RxList<PedidoModel> get listaPedidosAceptados => _listaPedidosAceptados;

  //Pedidos finalizados

  final RxList<PedidoModel> _listaPedidosFinalizados = <PedidoModel>[].obs;
  RxList<PedidoModel> get listaPedidosFinalizados => _listaPedidosFinalizados;
//Pedidos cancelados

  final RxList<PedidoModel> _listaPedidosCancelados = <PedidoModel>[].obs;
  RxList<PedidoModel> get listaPedidosCancelados => _listaPedidosCancelados;

  ///pARA EL DETALLE del pedido
  RxInt current_step = 0.obs;
  RxBool active_step1 = true.obs;
  RxBool active_step2 = false.obs;

  ///
  @override
  void onInit() {
    Future.wait([
      _cargarFotoPerfil(),
    ]);

    cargarListaPedidos(0);
    cargarListaPedidos(1);
    cargarListaPedidos(2);
    cargarListaPedidos(3);

    super.onInit();
  }

  /* METODOS  */
  Future<void> _cargarFotoPerfil() async {
    imagenUsuario.value =
        await _personaRepository.getImagenUsuarioActual() ?? '';
  }

  Future<String> _getNombresCliente(String cedula) async {
    final nombre =
        await _personaRepository.getNombresPersonaPorCedula(cedula: cedula);
    return nombre ?? 'Usuario';
  }

  Future<String> _getDireccionXLatLng(LatLng posicion) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(posicion.latitude, posicion.longitude);
    Placemark lugar = placemark[0];

//
    return _getDireccion(lugar);
  }

  String _getDireccion(Placemark lugar) {
    //
    if (lugar.subLocality?.isEmpty == true) {
      return lugar.street.toString();
    } else {
      return '${lugar.street}, ${lugar.subLocality}';
    }
  }

  //
  String formatoFecha(Timestamp fecha) {
    String formatoFecha = DateFormat.yMd("es").format(fecha.toDate());
    String formatoHora = DateFormat.Hm("es").format(fecha.toDate());
    return "$formatoFecha $formatoHora";
  }

//**** */
  final cargandoPedidos = true.obs;

  Future<void> cargarListaPedidos(int id) async {
    try {
      cargandoPedidos.value = true;
      final lista = (await _pedidosRepository.getPedidosPorField(
              field: 'idEstadoPedido', dato: categoriasPedidos[id].path)) ??
          [];

      //
      for (var i = 0; i < lista.length; i++) {
        final nombre = await _getNombresCliente(lista[i].idCliente);
        final direccion = await _getDireccionXLatLng(
            LatLng(lista[i].direccion.latitud, lista[i].direccion.longitud));
        lista[i].nombreUsuario = nombre;
        lista[i].direccionUsuario = direccion;
      }

//

      switch (id) {
        case 0:
          _listaPedidosEnEspera.value = lista;
          break;
        case 1:
          _listaPedidosAceptados.value = lista;
          break;
        case 2:
          _listaPedidosFinalizados.value = lista;
          break;
        case 3:
          _listaPedidosCancelados.value = lista;
          break;
        default:
      }
    } on FirebaseException {
      Mensajes.showGetSnackbar(
          titulo: 'Alerta',
          mensaje:
              'Ha ocurrido un error, por favor inténtelo de nuevo más tarde.',
          icono: const Icon(
            Icons.error_outline_outlined,
            color: Colors.white,
          ));
    }
    cargandoPedidos.value = false;
  }

  //Metodo para actualizar el estado de un pedido
  Future<void> actualizarEstadoPedido(String idPedido, int estado) async {
    try {
      //La categorias de los pedidos consta solo 4, el 5 es rechazados estado5 su indice 4
      if (estado == 4) {
        await _pedidosRepository.updateEstadoPedido(
            idPedido: idPedido, estadoPedido: "estado5");
      } else {
        await _pedidosRepository.updateEstadoPedido(
            idPedido: idPedido, estadoPedido: categoriasPedidos[estado].path);
      }
      //Variable para mostra el mensaje
      String titulo = "Mensaje";
      String mensaje =
          "Ha ocurrido un error, por favor inténtelo de nuevo más tarde.";
      IconData icono = Icons.error_outline_outlined;
      //Evaluar que estado se actualizo

      switch (estado) {
        case 0:
          mensaje = "Su pedido se realizo con éxito";
          icono = Icons.waving_hand_outlined;
          cargarListaPedidos(0);

          break;
        case 1:
          mensaje = "Pedido aceptado con éxito.";

          icono = Icons.check_outlined;
          cargarListaPedidos(1);
          cargarListaPedidos(0);
//
          current_step.value = current_step.value + 1;
          active_step1.value = false;
          active_step2.value = true;

          break;
        case 2:
          mensaje = "Pedido finalizado con éxito.";
          icono = Icons.check_outlined;
          cargarListaPedidos(2);
          cargarListaPedidos(1);
          break;
        case 3:
          mensaje = "Pedido cancelado.";
          icono = Icons.message_outlined;
          cargarListaPedidos(3);
          cargarListaPedidos(1);
          break;
        case 4:
          mensaje = "Pedido rechazado.";
          icono = Icons.message_outlined;
          //cargarListaPedidos(4);
          cargarListaPedidos(0);
          break;
      }
      Mensajes.showGetSnackbar(
          titulo: titulo,
          mensaje: mensaje,
          icono: Icon(
            icono,
            color: Colors.white,
          ));
    } on FirebaseException {
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
