import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/utils/mensajes.dart';
import 'package:gasjm/app/data/models/categoria_model.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/data/repository/pedido_repository.dart';
import 'package:gasjm/app/data/repository/persona_repository.dart';
import 'package:gasjm/app/data/repository/notificacion_repository.dart';
import 'package:gasjm/app/data/models/notificacion_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PedidoController extends GetxController {
  final _pedidosRepository = Get.find<PedidoRepository>();
  final _personaRepository = Get.find<PersonaRepository>();
  final _notificacionRepository = Get.find<NotificacionRepository>();

//
  final cargandoPedidos = true.obs;

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

  //Metodo para cargarLista de los pedidos para el administrador
  Future<void> cargarListaPedidosParaRepartidor(
      int indiceCategoriaPedido) async {
    try {
      cargandoPedidos.value = true;
      //
      switch (indiceCategoriaPedido) {
        //en Espera todos los pedidos
        case 0:
          final lista = (await _pedidosRepository.getPedidosPorField(
                  field: 'idEstadoPedido',
                  dato: categoriasPedidos[indiceCategoriaPedido].path)) ??
              [];

          //
          for (var i = 0; i < lista.length; i++) {
            final nombre = await _getNombresCliente(lista[i].idCliente);
            final direccion = await _getDireccionXLatLng(LatLng(
                lista[i].direccion.latitud, lista[i].direccion.longitud));
            lista[i].nombreUsuario = nombre;
            lista[i].direccionUsuario = direccion;
          }

//
          _listaPedidosEnEspera.value = lista;
          break;
        //aceptados  todos los pedidos del repartidor (usuario actual)
        //finalizados del dia  todos los pedidos del repartidor (usuario actual)
        default:
          var usuario = await _personaRepository.getUsuario();
          final lista = await _pedidosRepository.getPedidosPorDosQueries(
                  field1: "idEstadoPedido",
                  dato1: categoriasPedidos[indiceCategoriaPedido].path,
                  field2: "idRepartidor",
                  dato2: usuario!.uidPersona!) ??
              [];

          //
          for (var i = 0; i < lista.length; i++) {
            final nombre = await _getNombresCliente(lista[i].idCliente);
            final direccion = await _getDireccionXLatLng(LatLng(
                lista[i].direccion.latitud, lista[i].direccion.longitud));
            lista[i].nombreUsuario = nombre;
            lista[i].direccionUsuario = direccion;
          }

          //
          if (indiceCategoriaPedido == 1) {
            _listaPedidosAceptados.value = lista;
          } else {
            _listaPedidosFinalizados.value = lista;
          }
          //

          break;
        //
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

  //Metodo para cargarLista de los pedidos para el administrador
  Future<void> cargarListaPedidosParaAdministrador(int id) async {
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
  Future<void> actualizarEstadoPedido(
      String idPedido, int estado, int modo, String idCliente) async {
    ///en estadoPedido1 se guarda info   de si se acepta o rechaza el pedido en espera
    ///en estadoPedido3 se guarda info   de si se cancela o finaliza el pedidoaceptado
    //Por defecto estado5 rechazar
    //La categorias de los pedidos consta solo 4 de categoriasPedidos, el 5 es rechazados estado5 su indice 4 no consta en CategoriaPedidos

    var estadoAux = "estado5";
    //Por defecto numerodeestado2  para los pedidos en camino

    var numeroEstadoPedido = 'estadoPedido2';
    try {
      if (estado != 4) {
        estadoAux = categoriasPedidos[estado].path;
      }
      if (estado == 1 || estado == 4) {
        numeroEstadoPedido = 'estadoPedido1';
      }
      if (estado == 2 || estado == 3) {
        numeroEstadoPedido = 'estadoPedido3';
      }
      await _pedidosRepository.updateEstadoPedido(
          idPedido: idPedido,
          estadoPedido: estadoAux,
          numeroEstadoPedido: numeroEstadoPedido);
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
          modo == 0
              ? cargarListaPedidosParaAdministrador(0)
              : cargarListaPedidosParaRepartidor(0);

          break;
        case 1:
          mensaje = "Pedido aceptado con éxito.";

          icono = Icons.check_circle_outline_outlined;
          if (modo == 0) {
            cargarListaPedidosParaAdministrador(1);
            cargarListaPedidosParaAdministrador(0);
          } else {
            cargarListaPedidosParaRepartidor(1);
            cargarListaPedidosParaRepartidor(0);
          }

          break;
        case 2:
          mensaje = "Pedido finalizado con éxito.";
          icono = Icons.check_outlined;
          //
          if (modo == 0) {
            cargarListaPedidosParaAdministrador(2);
            cargarListaPedidosParaAdministrador(1);
          } else {
            cargarListaPedidosParaRepartidor(2);
            cargarListaPedidosParaRepartidor(1);
          }
          break;
        case 3:
          mensaje = "Pedido cancelado.";
          icono = Icons.message_outlined;
          if (modo == 0) {
            cargarListaPedidosParaAdministrador(3);
            cargarListaPedidosParaAdministrador(1);
          } else {
            cargarListaPedidosParaRepartidor(3);
            cargarListaPedidosParaRepartidor(1);
          }
          break;
        case 4:
          mensaje = "Pedido rechazado.";
          icono = Icons.message_outlined;
          //cargarListaPedidos(4);
          if (modo == 0) {
            cargarListaPedidosParaAdministrador(0);
          } else {
            cargarListaPedidosParaRepartidor(0);
          }
          break;
      }
      Mensajes.showGetSnackbar(
          titulo: titulo,
          mensaje: mensaje,
          icono: Icon(
            icono,
            color: Colors.white,
          ));
      //Enviar notificacion al cliente
      Notificacion _notificacionModel = Notificacion(
          fechaNotificacion: _personaRepository.fechaHoraActual,
          idEmisorNotificacion: _personaRepository.idUsuarioActual,
          idRemitenteNotificacion: idCliente,
          textoNotificacion: _personaRepository.nombreUsuarioActual,
          tituloNotificacion: mensaje);
      await _notificacionRepository.insertNotificacion(
          notificacionModel: _notificacionModel);
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

  //
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
    return "$formatoHora $formatoFecha";
  }
}
