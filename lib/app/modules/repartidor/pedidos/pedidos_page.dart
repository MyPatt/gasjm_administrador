import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/global_widgets/bottom_repartidor.dart';
import 'package:gasjm/app/global_widgets/menu_lateral.dart';
import 'package:gasjm/app/global_widgets/pedido/contenido_pedido.dart';
import 'package:gasjm/app/modules/repartidor/pedidos/pedidos_controller.dart';
import 'package:gasjm/app/modules/repartidor/pedidos/widgets/modal_ordenamiento.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';

class PedidosPage extends StatelessWidget {
  const PedidosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PedidosController>(
        builder: (_) => Scaffold(
            backgroundColor: AppTheme.background,
            //Menú deslizable a la izquierda con opciones del  usuario
            drawer: MenuLateral(
                modo: 'Modo administrador', imagenPerfil: _.imagenUsuario),

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
                    onPressed: () =>
                        Get.toNamed(AppRoutes.buscarAdministrador)),
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
              length: 3,
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: TabBar(
                      labelStyle: Theme.of(context)
                          .textTheme
                          .subtitle2
                          ?.copyWith(fontWeight: FontWeight.w700),
                      indicatorColor: AppTheme.blueBackground,
                      labelColor: AppTheme.blueBackground,
                      unselectedLabelColor: AppTheme.light,
                      isScrollable: true,
                      // El repartidor vera todos los pedidos en espera, en camabio  aceptados y finalizados solo por el
                      tabs: <Widget>[
                        Obx(() => Tab(
                              text:
                                  'En espera (${_.controladorDePedidos.listaPedidosEnEspera.length})',
                            )),
                        Obx(() => Tab(
                              text:
                                  'Aceptados (${_.controladorDePedidos.listaPedidosAceptados.length})',
                            )),
                        Obx(() => Tab(
                            text:
                                "Finalizados (${_.controladorDePedidos.listaPedidosFinalizados.length})"))
                      ],
                    ),
                  ),
                  Expanded(
                      child: TabBarView(children: [
                    //se envia el modo para cargar la lista de los pedidos el administrador carga de todos
                    //y el repartidor solo los correspondientes y al actualizar se cargan de nuevo la lista
                    //refactorizado el codigo actualizar para usar por el administrador y repartidor
                    // 0 administrador
                    //1 repartidor
                    //Ver pedidos en espera como repartidor
                    /*
                    (indiceCategoriaPedido == 0
                              ? controladorDePedidos.listaPedidosEnEspera.value
                              : indiceCategoriaPedido == 1
                                  ? controladorDePedidos
                                      .listaPedidosAceptados.value
                                  : indiceCategoriaPedido == 2
                                      ? controladorDePedidos
                                          .listaPedidosFinalizados.value
                                      : controladorDePedidos
                                          .listaPedidosCancelados.value)
                    */
                    ContenidoPedido(
                      indiceCategoriaPedido: 0,
                      modo: 1,
                      listaPedidos: _.controladorDePedidos.listaPedidosEnEspera,
                    ),
                    //Ver pedidos aceptados como repartidor
                    ContenidoPedido(
                      indiceCategoriaPedido: 1,
                      modo: 1,
                      listaPedidos:
                          _.controladorDePedidos.listaPedidosAceptados,
                    ),
                    //Ver pedidos finalizados como repartidor
                    ContenidoPedido(
                      indiceCategoriaPedido: 2,
                      modo: 1,
                      listaPedidos:
                          _.controladorDePedidos.listaPedidosFinalizados,
                    ),
                    // const ContenidoHistorial()
                  ]))
                ],
              ),
            ),
            bottomNavigationBar:
                const BottomNavigationRepartidor(indiceActual: 2)));
  }
}
