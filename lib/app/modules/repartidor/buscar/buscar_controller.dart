import 'package:flutter/material.dart';
import 'package:gasjm/app/data/controllers/pedido_controller.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:get/get.dart';

class BuscarController extends GetxController {
  /* VARIABLES*/

  //
  final TextEditingController controladorBuscarTexto = TextEditingController();

  //
  final PedidoController controladorDePedidos = Get.put(PedidoController());

  //
  List<PedidoModel> lista1=[];
  List<PedidoModel> lista2=[];
  List<PedidoModel> lista3=[];
  /* METODOS PROPIOS */
  @override
  Future<void> onInit() async {
    super.onInit();

    lista1 = controladorDePedidos.listaPedidosEnEspera;
    lista2 = controladorDePedidos.listaPedidosAceptados;
    lista3 = controladorDePedidos.listaPedidosFinalizados;

    /*

    controladorDePedidos.cargarListaPedidosParaRepartidor(0);
    controladorDePedidos.cargarListaPedidosParaRepartidor(1);
    controladorDePedidos.cargarListaPedidosParaRepartidor(2);
    */
  }

  buscarPedidos(String valor) {
    var aux1 =  lista1
        .where((pedido) =>
            pedido.nombreUsuario!.contains(controladorBuscarTexto.text) ||
            pedido.direccionUsuario!.contains(controladorBuscarTexto.text))
        .toList();

    var aux2 = lista2
        .where((pedido) =>
            pedido.nombreUsuario!.contains(controladorBuscarTexto.text) ||
            pedido.direccionUsuario!.contains(controladorBuscarTexto.text))
        .toList();

    var aux3 = lista3
        .where((pedido) =>
            pedido.nombreUsuario!.contains(controladorBuscarTexto.text) ||
            pedido.direccionUsuario!.contains(controladorBuscarTexto.text))
        .toList();

    controladorDePedidos.listaPedidosEnEspera.value = aux1;
    controladorDePedidos.listaPedidosAceptados.value = aux1;
    controladorDePedidos.listaPedidosFinalizados.value = aux1;
    print(valor);
    print(aux2.length);
  }
}
