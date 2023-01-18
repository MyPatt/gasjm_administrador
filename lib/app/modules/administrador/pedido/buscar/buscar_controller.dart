import 'package:flutter/material.dart';
import 'package:gasjm/app/data/controllers/pedido_controller.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:get/get.dart';

class BuscarPedidosAdminController extends GetxController {
  /* VARIABLES*/

  //Controlador de Pedidos (general)
  final PedidoController controladorDePedidos = Get.put(PedidoController());

  //Controlador de texto para el input de busqueda
  final TextEditingController controladorBuscarTexto = TextEditingController();

  //Existe texto en el input de buqueda?
  final RxBool existeTexoParaBuscar = false.obs;

  //Lista para Pedidos en espera

  final RxList<PedidoModel> _listaPedidosEnEspera = <PedidoModel>[].obs;
  RxList<PedidoModel> get listaPedidosEnEspera => _listaPedidosEnEspera;

  //Lista para Pedidos aceptados

  final RxList<PedidoModel> _listaPedidosAceptados = <PedidoModel>[].obs;
  RxList<PedidoModel> get listaPedidosAceptados => _listaPedidosAceptados;

  //Lista para Pedidos finalizados

  final RxList<PedidoModel> _listaPedidosFinalizados = <PedidoModel>[].obs;
  RxList<PedidoModel> get listaPedidosFinalizados => _listaPedidosFinalizados;

  //Lista para Pedidos cancelados

  final RxList<PedidoModel> _listaPedidosCancelados = <PedidoModel>[].obs;
  RxList<PedidoModel> get listaPedidosCancelados => _listaPedidosCancelados;

  /* METODOS PROPIOS */
  @override
  Future<void> onInit() async {
    super.onInit();
  }

  /* METODOS */

  //Metodo para filtrar de la lista principal de pedidos
  buscarPedidos(String valor) {
    //Si esta vacio el input
    if (valor.isEmpty) {
      
    //El icono de borrar deshabilitar
    existeTexoParaBuscar.value = false;

    //
      //Limpiar listas
    _listaPedidosEnEspera.value = [];
    _listaPedidosAceptados.value = [];
    _listaPedidosFinalizados.value = [];
    _listaPedidosCancelados.value = [];
      return;
    }

    //Filtro de listas, todo en minuscular para optimizar la busqueda

    _listaPedidosEnEspera.value = controladorDePedidos.listaPedidosEnEspera
        .where((pedido) =>
            pedido.nombreUsuario!
                .toLowerCase()
                .contains(controladorBuscarTexto.text.toLowerCase()) ||
            pedido.direccionUsuario!
                .toLowerCase()
                .contains(controladorBuscarTexto.text.toLowerCase()))
        .toList();

    _listaPedidosAceptados.value = controladorDePedidos.listaPedidosAceptados
        .where((pedido) =>
            pedido.nombreUsuario!
                .toLowerCase()
                .contains(controladorBuscarTexto.text.toLowerCase()) ||
            pedido.direccionUsuario!
                .toLowerCase()
                .contains(controladorBuscarTexto.text.toLowerCase()))
        .toList();

    _listaPedidosFinalizados.value = controladorDePedidos
        .listaPedidosFinalizados
        .where((pedido) =>
            pedido.nombreUsuario!
                .toLowerCase()
                .contains(controladorBuscarTexto.text.toLowerCase()) ||
            pedido.direccionUsuario!
                .toLowerCase()
                .contains(controladorBuscarTexto.text.toLowerCase()))
        .toList();

           _listaPedidosCancelados.value = controladorDePedidos
        .listaPedidosCancelados
        .where((pedido) =>
            pedido.nombreUsuario!
                .toLowerCase()
                .contains(controladorBuscarTexto.text.toLowerCase()) ||
            pedido.direccionUsuario!
                .toLowerCase()
                .contains(controladorBuscarTexto.text.toLowerCase()))
        .toList();
    //El icono de borrar habilitar
    existeTexoParaBuscar.value = true;
  }

  //Metodo que borra la busqueda y limpia las listas
  void limpiarBusqueda() {
    //Borrar el texto del input
    controladorBuscarTexto.text = '';

    //El icono de borrar deshabilitar
    existeTexoParaBuscar.value = false;

    //Limpiar listas
    _listaPedidosEnEspera.value = [];
    _listaPedidosAceptados.value = [];
    _listaPedidosFinalizados.value = [];
    _listaPedidosCancelados.value = [];

  }

  
}
