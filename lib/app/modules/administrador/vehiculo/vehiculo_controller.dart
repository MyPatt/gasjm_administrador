import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/utils/mensajes.dart';
import 'package:gasjm/app/data/models/categoria_model.dart';
import 'package:gasjm/app/data/models/persona_model.dart';
import 'package:gasjm/app/data/repository/persona_repository.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';

class VehiculoController extends GetxController {
  late CategoriaModelo _categoria;
  CategoriaModelo get house => _categoria;

  final _personaRepository = Get.find<PersonaRepository>();

  final cargandoClientes = true.obs;

//Listas observables de los clientes

  final RxList<PersonaModel> _listaRepartidores = <PersonaModel>[].obs;
  RxList<PersonaModel> get listaRepartidores => _listaRepartidores;

  final RxList<PersonaModel> _listaFiltradaRepartidores = <PersonaModel>[].obs;
  RxList<PersonaModel> get listaFiltradaRepartidores =>
      _listaFiltradaRepartidores;

  /* METODOS PROPIOS */
  @override
  void onInit() {
    // _categoria = Get.arguments as CategoryModel;
    _cargarListaDeRepartidores();

    super.onInit();
  }

  /* METODOS PARA CLIENTES */

  void _cargarListaFiltradaDeRepartidores() {
   
    List<PersonaModel> resultado = [];

    resultado = _listaRepartidores
        //.where((pedido) => pedido.cedulaPersona == filtro)

        .toList();

    _listaFiltradaRepartidores.value = resultado;
  }

  void _cargarListaDeRepartidores() async {
    try {
      cargandoClientes.value = true;

      final lista = (await _personaRepository.getPersonasPorField(
          field: 'idPerfil', dato: 'repartidor'));

      _listaRepartidores.value = lista;
      //Cargar la lista filtrada al inicio todos
//      _listaFiltradaPedidosEnEspera.value = _listaPedidosEnEspera;
      _cargarListaFiltradaDeRepartidores();
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
    cargandoClientes.value = false;
  }

  void cargarDetalleDelRepartidor(PersonaModel cliente) {
    Get.offNamed(AppRoutes.detalleCliente, arguments: cliente);
  }
}
