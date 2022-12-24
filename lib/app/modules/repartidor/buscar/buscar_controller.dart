import 'package:flutter/material.dart';
import 'package:gasjm/app/data/controllers/pedido_controller.dart';
import 'package:gasjm/app/data/repository/persona_repository.dart';
import 'package:get/get.dart';

class BuscarController extends GetxController {
  /* VARIABLES*/

  final _personaRepository = Get.find<PersonaRepository>();

  //
  final TextEditingController controladorBuscarTexto = TextEditingController();

  //
  final PedidoController controladorDePedidos = Get.put(PedidoController());

  ///
  /* METODOS PROPIOS */
  @override
  Future<void> onInit() async {
    super.onInit();

    /*

    controladorDePedidos.cargarListaPedidosParaRepartidor(0);
    controladorDePedidos.cargarListaPedidosParaRepartidor(1);
    controladorDePedidos.cargarListaPedidosParaRepartidor(2);
    */
  }

  buscarPedidos(String valor) {
    print(valor);
  }
}
