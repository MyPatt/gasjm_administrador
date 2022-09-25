import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/utils/mensajes.dart';
import 'package:gasjm/app/data/models/category_model.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/data/models/persona_model.dart';
import 'package:gasjm/app/data/repository/pedido_repository.dart';
import 'package:gasjm/app/data/repository/persona_repository.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClienteController extends GetxController {
  late CategoryModel _house;
  CategoryModel get house => _house;

  final _pedidosRepository = Get.find<PedidoRepository>();
  final _personaRepository = Get.find<PersonaRepository>();

  final cargandoPedidosEnEspera = true.obs;

//Pedidos finalizados

  final RxList<PersonaModel> _listaPedidosEnEspera = <PersonaModel>[].obs;
  RxList<PersonaModel> get listaPedidosEnEspera => _listaPedidosEnEspera;

  final RxList<PersonaModel> _listaFiltradaPedidosEnEspera = <PersonaModel>[].obs;
  RxList<PersonaModel> get listaFiltradaPedidosEnEspera =>
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
  //Lista para filtrar los pedidos por dias

  List<String> dropdownItemsDeFiltro = [
    "Todos",
    "Ahora",
    "Mañana",
  ];

  RxString valorSeleccionadoItemDeFiltro = 'Todos'.obs;
  @override
  void onInit() {
    this._house = Get.arguments as CategoryModel;
    cargarListaPedidosEnEspera();
    valorSeleccionadoItemDeOrdenamiento.value = dropdownItemsDeOrdenamiento[0];
    dropdownItemsDeOrdenamiento[0];
    valorSeleccionadoItemDeFiltro.value = dropdownItemsDeFiltro[0];

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

  void _cargarListaFiltradaDePedidos(
      RxList<PersonaModel> listaPorFiltrar,
      RxList<PersonaModel> litaFiltrada,
      String filtroDia,
      String ordenarCategoria) {
    if (filtroDia == "Todos") {
      litaFiltrada.value = listaPorFiltrar.value;
      ordenarListaFiltradaDePedidos(litaFiltrada.value, ordenarCategoria);

      return;
    }
    List<PersonaModel> resultado = [];

    resultado = listaPorFiltrar
        .where((pedido) => pedido.cedulaPersona == filtroDia)
        .toList();

    litaFiltrada.value = resultado;
    ordenarListaFiltradaDePedidos(litaFiltrada.value, ordenarCategoria);
  }

  void ordenarListaFiltradaDePedidos(
      List<PersonaModel> listaFiltrada, String ordenarCategoria) {
    if (ordenarCategoria == dropdownItemsDeOrdenamiento[0]) {
      listaFiltrada
          .sort((a, b) => a.cedulaPersona.compareTo(b.cedulaPersona));

      return;
    }
 
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
      final lista = (await _personaRepository.getPersonasPorField(
              field: 'idPerfil', dato: 'cliente')) 
  ;

      _listaPedidosEnEspera.value = lista;
      //Cargar la lista filtrada al inicio todos
//      _listaFiltradaPedidosEnEspera.value = _listaPedidosEnEspera;
      cargarListaFiltradaDePedidosEnEspera();

      // 
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
