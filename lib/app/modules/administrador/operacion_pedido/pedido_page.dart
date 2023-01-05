import 'package:gasjm/app/global_widgets/bottom_administrador.dart';
import 'package:gasjm/app/global_widgets/menu_lateral.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/global_widgets/pedido/contenido_pedido.dart';
import 'package:gasjm/app/modules/administrador/operacion_pedido/pedido_controller.dart';
import 'package:gasjm/app/modules/repartidor/pedidos/widgets/modal_ordenamiento.dart';
import 'package:gasjm/app/routes/app_routes.dart';

import 'package:get/get.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';

class OperacionPedidoPage extends StatelessWidget {
  const OperacionPedidoPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OperacionPedidoController>(
        builder: (_) => Scaffold(
            backgroundColor: AppTheme.background,
            //Menú deslizable a la izquierda con opciones del  usuario
            drawer: MenuLateral(
                modo: 'Modo repartidor', imagenPerfil: _.imagenUsuario),

            //
            appBar: AppBar(
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
              ),
              backgroundColor: AppTheme.blueBackground,
              actions: [
                IconButton(
                    icon: const Icon(Icons.search_outlined),
                    onPressed: () => Get.toNamed(AppRoutes.buscarPedidosAdmin)),
                IconButton(
                    icon: const Icon(
                      Icons.sort_outlined,
                    ),
                    onPressed: () => showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) => ModalOrdenamiento(
                            listaCategoriasDeOrdenamiento:
                                _.listaCategoriasDeOrdenamiento,
                            selectedRadioTile: _.indiceCategoriaSeleccionada,
                            onChanged: (valor) =>
                                _.seleccionarOpcionDeOrdenamiento(valor),
                          ),
                        ))
              ],
              title: const Text("Pedidos"),
            ),
            body: DefaultTabController(
              length: 4,
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: TabBar(
                      isScrollable: true,
                      indicatorColor: AppTheme.blueBackground,
                      labelColor: AppTheme.blueBackground,
                      unselectedLabelColor: AppTheme.light,
                      // indicator: BoxDecoration(color: Colors.white),
                      /*
                      tabs: categoriasPedidos
                          .map((e) => Tab(
                                text: e.name,
                              ))
                          .toList(),
                          */
                      //
                      tabs: <Widget>[
                        Obx(() => Tab(
                            text:
                                'En espera (${_.controladorDePedidos.listaPedidosEnEspera.length})')),
                        Obx(() => Tab(
                              text:
                                  'Aceptados (${_.controladorDePedidos.listaPedidosAceptados.length})',
                            )),
                        Obx(() => Tab(
                            text:
                                "Finalizados (${_.controladorDePedidos.listaPedidosFinalizados.length}) ")),
                        Obx(() => Tab(
                            text:
                                "Cancelados (${_.controladorDePedidos.listaPedidosCancelados.length}) "))
                      ],
                    ),
                  ),
                  Expanded(
                      child: TabBarView(children: [
                    //modo
                    // 0 administrador
                    //1 repartidor
                    ContenidoPedido(
                        indiceCategoriaPedido: 0,
                        modo: 0,
                        listaPedidos:
                            _.controladorDePedidos.listaPedidosEnEspera),
                    ContenidoPedido(
                        indiceCategoriaPedido: 1,
                        modo: 0,
                        listaPedidos:
                            _.controladorDePedidos.listaPedidosAceptados),
                    ContenidoPedido(
                        indiceCategoriaPedido: 2,
                        modo: 0,
                        listaPedidos:
                            _.controladorDePedidos.listaPedidosFinalizados),
                    ContenidoPedido(
                        indiceCategoriaPedido: 3,
                        modo: 0,
                        listaPedidos:
                            _.controladorDePedidos.listaPedidosCancelados),
                  ]))
                ],
              ),
            ),
            bottomNavigationBar:
                const BottomNavigationAdministrador(indiceActual: 2)));
  }
}
