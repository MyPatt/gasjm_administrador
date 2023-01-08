import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/utils/mensajes.dart';
import 'package:gasjm/app/data/models/persona_model.dart';
import 'package:gasjm/app/data/repository/persona_repository.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';

class ClienteController extends GetxController {
  //Variable  para imagen de perfil
  RxString imagenUsuario = ''.obs;

  final _personaRepository = Get.find<PersonaRepository>();

  final cargandoClientes = true.obs;

  //Listas observables de todos los clientes activos

  final RxList<PersonaModel> _listaClientes = <PersonaModel>[].obs;
  RxList<PersonaModel> get listaClientes => _listaClientes;

//Listas para filtrar lista de clientes

  final RxList<PersonaModel> _listaFiltraDeClientes = <PersonaModel>[].obs;
  RxList<PersonaModel> get listaFiltraDeClientes => _listaFiltraDeClientes;

  //
  Rx<bool> existeImagenPerfil = false.obs;

  //Existe texto en el input de buqueda?
  final RxBool existeTexoParaBuscar = false.obs;
  //Controlador de texto para el input de busqueda
  final TextEditingController controladorBuscarTexto = TextEditingController();
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

  void _cargarListaDeClientes() async {
    try {
      cargandoClientes.value = true;

      final lista = (await _personaRepository.getPersonasPorField(
          field: 'idPerfil', dato: 'cliente'));
      //ordenar
      for (var i = 0; i < lista.length; i++) {
        final nombre = '${lista[i].nombrePersona} ${lista[i].apellidoPersona}';
        lista[i].nombreUsuario = nombre;
      }

      lista.sort(
          (a, b) => a.nombreUsuario!.compareTo(b.nombreUsuario.toString()));

      //
      _listaClientes.value = lista;

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
    Get.toNamed(AppRoutes.detalleCliente, arguments: [cliente, false]);
  }

  //

  Future<void> eliminarCliente(String id) async {
    try {
      await _personaRepository.updateEstadoPersona(
          uid: id, estado: "eliminado");

      //
      Mensajes.showGetSnackbar(
          titulo: "Mensaje",
          mensaje: "Cliente eliminado con éxito.",
          icono: const Icon(
            Icons.delete_outline_outlined,
            color: Colors.white,
          ));
          
//Volver a actualizar la lista de clientes activos desde firestore
      _cargarListaDeClientes();

//Verificar si no se encuentra en la pagina de busqueda para actualizar la lista filtrada
if(existeTexoParaBuscar.value){
   _listaFiltraDeClientes.value = listaClientes
        .where((pedido) => pedido.nombreUsuario!
            .toLowerCase()
            .contains(controladorBuscarTexto.text.toLowerCase()))
        .toList();
}

    } catch (e) {
      Mensajes.showGetSnackbar(
          titulo: "Alerta",
          mensaje:
              "Ha ocurrido un error, por favor inténtelo de nuevo más tarde.",
          icono: const Icon(
            Icons.error_outline_outlined,
            color: Colors.white,
          ));
    }
  }

  //Metodo para filtrar de la lista principal de pedidos
  buscarPedidos(String valor) {
    //Si esta vacio el input
    if (valor.isEmpty) {
      //El icono de borrar deshabilitar
      existeTexoParaBuscar.value = false;

      //Limpiar lista
      _listaFiltraDeClientes.clear();

      return;
    }

    //Filtro de lista, todo en minuscular para optimizar la busqueda

 _filtrarListaClientes();

    //El icono de borrar habilitar
    existeTexoParaBuscar.value = true;
  }

//Metodo que borra la busqueda y limpia las listas
  void limpiarBusqueda() {
    //Borrar el texto del input
    controladorBuscarTexto.text = '';

    //El icono de borrar deshabilitar
    existeTexoParaBuscar.value = false;

    //Limpiar lista
    _listaFiltraDeClientes.clear();
  }
  
  void _filtrarListaClientes() {
       _listaFiltraDeClientes.value = listaClientes
        .where((pedido) => pedido.nombreUsuario!
            .toLowerCase()
            .contains(controladorBuscarTexto.text.toLowerCase()))
        .toList();
  }
}
