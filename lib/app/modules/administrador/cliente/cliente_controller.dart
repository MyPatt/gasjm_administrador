import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/utils/mensajes.dart';
import 'package:gasjm/app/data/models/categoria_model.dart';
import 'package:gasjm/app/data/models/persona_model.dart';
import 'package:gasjm/app/data/repository/persona_repository.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';

class ClienteController extends GetxController {
  //Variable  para imagen de perfil
  RxString imagenUsuario = ''.obs;

  //
  late CategoriaModelo _categoria;
  CategoriaModelo get house => _categoria;

  final _personaRepository = Get.find<PersonaRepository>();

  final cargandoClientes = true.obs;

//Listas observables de los clientes

  final RxList<PersonaModel> _listaClientes = <PersonaModel>[].obs;
  RxList<PersonaModel> get listaClientes => _listaClientes;

  final RxList<PersonaModel> _listaFiltradaClientes = <PersonaModel>[].obs;
  RxList<PersonaModel> get listaFiltradaClientes => _listaFiltradaClientes;

  /* METODOS PROPDIO */
  @override
  void onInit() {
    // _categoria = Get.arguments as CategoryModel;
    _cargarListaDeClientes();
//
    _cargarFotoPerfil();
    super.onInit();
  }

  //Obtener foto de perfil del usuario
  Future<void> _cargarFotoPerfil() async {
    imagenUsuario.value =
        await _personaRepository.getImagenUsuarioActual() ?? '';
  }

  //Volver a cargar la lista de los clientes
     Future<void> pullRefrescar() async {
    
   _cargarListaDeClientes();
    await Future.delayed(const Duration(seconds: 2));
  }

  /* METODOS PARA CLIENTES */

  void _cargarListaFiltradaDeClientes() {
    String filtro = '';
    List<PersonaModel> resultado = [];

    resultado = _listaClientes
        //.where((pedido) => pedido.cedulaPersona == filtro)

        .toList();

    _listaFiltradaClientes.value = resultado;
  }

  void _cargarListaDeClientes() async {
    try {
      cargandoClientes.value = true;

      final lista = (await _personaRepository.getPersonasPorField(
          field: 'idPerfil', dato: 'cliente'));

      _listaClientes.value = lista;
      //Cargar la lista filtrada al inicio todos
//      _listaFiltradaPedidosEnEspera.value = _listaPedidosEnEspera;
      _cargarListaFiltradaDeClientes();

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

  void cargarDetalleDelCliente(PersonaModel cliente) {
    Get.offNamed(AppRoutes.detalleCliente, arguments: cliente);
  }
}
