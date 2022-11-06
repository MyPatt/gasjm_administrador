import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/utils/mensajes.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/data/repository/pedido_repository.dart';
import 'package:gasjm/app/data/repository/persona_repository.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DOperacionPedidoController extends GetxController {
  final _pedidosRepository = Get.find<PedidoRepository>();
  final _personaRepository = Get.find<PersonaRepository>();
//
  RxString imagenUsuario = ''.obs;
  //
  final cargandoPedidosEnEspera = true.obs;
  final cargandoPedidosAceptados = true.obs;
  //Filtro para pedidos aceptados
  final RxList<PedidoModel> _listaPedidosAceptados = <PedidoModel>[].obs;
  RxList<PedidoModel> get listaPedidosAceptados => _listaPedidosAceptados;

  final RxList<PedidoModel> _listaFiltradaPedidosAceptados =
      <PedidoModel>[].obs;
  RxList<PedidoModel> get listaFiltradaPedidosAceptados =>
      _listaFiltradaPedidosAceptados;

//Pedidos finalizados

  final RxList<PedidoModel> _listaPedidosEnEspera = <PedidoModel>[].obs;
  RxList<PedidoModel> get listaPedidosEnEspera => _listaPedidosEnEspera;

  final RxList<PedidoModel> _listaFiltradaPedidosEnEspera = <PedidoModel>[].obs;
  RxList<PedidoModel> get listaFiltradaPedidosEnEspera =>
      _listaFiltradaPedidosEnEspera;
  //Lista para ordenar los pedidos por diferentes categorias

  List<String> dropdownItemsDeOrdenamiento = [
    "Ordenar por fecha",
    "Ordenar por cantidad",
    "Ordenar por tiempo",
    "Ordenar por dirección",
    "Ordenar por cliente"
  ];

  RxString valorSeleccionadoItemDeOrdenamiento = 'Ordenar por'.obs;
  RxString valorSeleccionadoItemDeOrdenamientoAceptados = 'Ordenar por'.obs;
  //Lista para filtrar los pedidos por dias

  List<String> dropdownItemsDeFiltro = [
    "Todos",
    "Ahora",
    "Mañana",
  ];

  RxString valorSeleccionadoItemDeFiltro = 'Todos'.obs;
  RxString valorSeleccionadoItemDeFiltroAceptados = 'Todos'.obs;
  @override
  void onInit() {
    Future.wait([
      _cargarFotoPerfil(),
    ]);
    cargarListaPedidosEnEspera();
    valorSeleccionadoItemDeOrdenamiento.value = dropdownItemsDeOrdenamiento[0];
    valorSeleccionadoItemDeOrdenamientoAceptados.value =
        dropdownItemsDeOrdenamiento[0];
    valorSeleccionadoItemDeFiltro.value = dropdownItemsDeFiltro[0];
    valorSeleccionadoItemDeFiltroAceptados.value = dropdownItemsDeFiltro[0];
    cargarListaPedidosAceptados();

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /* METODOS  */
  Future<void> _cargarFotoPerfil() async {
    imagenUsuario.value =
        await _personaRepository.getImagenUsuarioActual() ?? '';
  }

//
  void cargarListaFiltradaDePedidosAceptados() {
    final filtroDia = valorSeleccionadoItemDeFiltroAceptados.value;
    final ordenarCategoria = valorSeleccionadoItemDeOrdenamientoAceptados.value;

    _cargarListaFiltradaDePedidos(_listaPedidosAceptados,
        _listaFiltradaPedidosAceptados, filtroDia, ordenarCategoria);
  }

  void _cargarListaFiltradaDePedidos(
      RxList<PedidoModel> listaPorFiltrar,
      RxList<PedidoModel> litaFiltrada,
      String filtroDia,
      String ordenarCategoria) {
    if (filtroDia == "Todos") {
      litaFiltrada.value = listaPorFiltrar.value;
      ordenarListaFiltradaDePedidos(litaFiltrada.value, ordenarCategoria);

      return;
    }
    List<PedidoModel> resultado = [];

    resultado = listaPorFiltrar
        .where((pedido) => pedido.diaEntregaPedido == filtroDia)
        .toList();

    litaFiltrada.value = resultado;
    ordenarListaFiltradaDePedidos(litaFiltrada.value, ordenarCategoria);
  }

  void ordenarListaFiltradaDePedidos(
      List<PedidoModel> listaFiltrada, String ordenarCategoria) {
    if (ordenarCategoria == dropdownItemsDeOrdenamiento[0]) {
      listaFiltrada
          .sort((a, b) => a.fechaHoraPedido.compareTo(b.fechaHoraPedido));

      return;
    }

    if (ordenarCategoria == dropdownItemsDeOrdenamiento[1]) {
      listaFiltrada
          .sort((a, b) => a.cantidadPedido.compareTo(b.cantidadPedido));

      return;
    }
    if (ordenarCategoria == dropdownItemsDeOrdenamiento[2]) {
      listaFiltrada
          .sort((a, b) => a.tiempoEntrega!.compareTo(b.tiempoEntrega ?? 0));

      return;
    }
    if (ordenarCategoria == dropdownItemsDeOrdenamiento[3]) {
      listaFiltrada.sort((a, b) =>
          a.direccionUsuario!.compareTo(b.direccionUsuario.toString()));
      return;
    }
    if (ordenarCategoria == dropdownItemsDeOrdenamiento[4]) {
      listaFiltrada.sort(
          (a, b) => a.nombreUsuario!.compareTo(b.nombreUsuario.toString()));
      return;
    }
  }

  ordenarListaFiltradaDePedidosAceptados() {
    final ordenarCategoria = valorSeleccionadoItemDeOrdenamientoAceptados.value;
    ordenarListaFiltradaDePedidos(
        _listaFiltradaPedidosAceptados, ordenarCategoria);
  }

  void cargarListaPedidosAceptados() async {
    try {
      cargandoPedidosAceptados.value = true;
      final lista = (await _pedidosRepository.getPedidosPorField(
              field: 'idEstadoPedido', dato: 'estado2')) ??
          [];

      //
      for (var i = 0; i < lista.length; i++) {
        final nombre = await _getNombresCliente(lista[i].idCliente);
        final direccion = await _getDireccionXLatLng(
            LatLng(lista[i].direccion.latitud, lista[i].direccion.longitud));
        lista[i].nombreUsuario = nombre;
        lista[i].direccionUsuario = direccion;
      }

      _listaPedidosAceptados.value = lista;
      // _listaFiltradaPedidosAceptados.value = _listaPedidosAceptados.value;
      cargarListaFiltradaDePedidosAceptados();
    } on FirebaseException {
      Mensajes.showGetSnackbar(
          titulo: "Error",
          mensaje: "Se produjo un error inesperado.",
          icono: const Icon(
            Icons.error_outline_outlined,
            color: Colors.white,
          ));
    }
    cargandoPedidosAceptados.value = false;
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

  /* METODOS PARA PEDIDOS FINALIZADOS */

  void cargarListaPedidosEnEspera() async {
    try {
      cargandoPedidosEnEspera.value = true;
      final lista = (await _pedidosRepository.getPedidosPorField(
              field: 'idEstadoPedido', dato: 'estado3')) ??
          [];

      //
      for (var i = 0; i < lista.length; i++) {
        final nombre = await _getNombresCliente(lista[i].idCliente);
        final direccion = await _getDireccionXLatLng(
            LatLng(lista[i].direccion.latitud, lista[i].direccion.longitud));
        lista[i].nombreUsuario = nombre;
        lista[i].direccionUsuario = direccion;
      }

      _listaPedidosEnEspera.value = lista;
      //Cargar la lista filtrada al inicio todos
//      _listaFiltradaPedidosEnEspera.value = _listaPedidosEnEspera;
      cargarListaFiltradaDePedidosEnEspera();

      //
      print(_listaFiltradaPedidosEnEspera.value.length);
    } on FirebaseException {
      Mensajes.showGetSnackbar(
          titulo: "Error",
          mensaje: "Se produjo un error inesperado.",
          icono: const Icon(
            Icons.error_outline_outlined,
            color: Colors.white,
          ));
    }
    cargandoPedidosEnEspera.value = false;
  }

  void cargarListaFiltradaDePedidosEnEspera() {
    final filtroDia = valorSeleccionadoItemDeFiltro.value;
    final ordenarCategoria = valorSeleccionadoItemDeOrdenamiento.value;
    _cargarListaFiltradaDePedidos(_listaPedidosEnEspera,
        _listaFiltradaPedidosEnEspera, filtroDia, ordenarCategoria);
  }

  ordenarListaFiltradaDePedidosEnEspera() {
    final ordenarCategoria = valorSeleccionadoItemDeOrdenamiento.value;

    ordenarListaFiltradaDePedidos(
        _listaFiltradaPedidosEnEspera, ordenarCategoria);
  }
}
