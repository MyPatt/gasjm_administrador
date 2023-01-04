import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/global_widgets/pedido/contenido_pedido.dart';
import 'package:gasjm/app/modules/administrador/buscar/buscar_controller.dart';
import 'package:gasjm/app/modules/administrador/buscar/widgets/buscar.dart';
import 'package:get/get.dart';

class BuscarAdministradorPage extends StatelessWidget {
  const BuscarAdministradorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BuscarAdministradorController>(
        builder: (_) => Scaffold(
              backgroundColor: AppTheme.background,

              //
              appBar: AppBar(
                automaticallyImplyLeading: true,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(10),
                  ),
                ),
                backgroundColor: AppTheme.blueBackground,
                title: Buscar(
                  controller: _.controladorBuscarTexto,
                  onChanged: (String valor) => _.buscarPedidos(valor),
                  onTap: _.limpiarBusqueda,
                  existeTexoParaBuscar: _.existeTexoParaBuscar,
                ),
              ),
              body: DefaultTabController(
                length: 4,
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
                                    'En espera (${_.listaPedidosEnEspera.length})',
                              )),
                          Obx(() => Tab(
                                text:
                                    'Aceptados (${_.listaPedidosAceptados.length})',
                              )),
                          Obx(() => Tab(
                              text:
                                  "Finalizados (${_.listaPedidosFinalizados.length})")),
                          Obx(() => Tab(
                              text:
                                  "Cancelados (${_.listaPedidosCancelados.length}) "))
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
                      //Ver pedidos en espera como admin
                      ContenidoPedido(
                        indiceCategoriaPedido: 0,
                        modo: 1,
                        listaPedidos: _.listaPedidosEnEspera,
                      ),
                      //Ver pedidos aceptados como admin
                      ContenidoPedido(
                          indiceCategoriaPedido: 1,
                          modo: 1,
                          listaPedidos: _.listaPedidosAceptados),
                      //Ver pedidos finalizados como admin
                      ContenidoPedido(
                          indiceCategoriaPedido: 2,
                          modo: 1,
                          listaPedidos: _.listaPedidosFinalizados),
                      //Ver pedidos cancelados como admin
                      ContenidoPedido(
                          indiceCategoriaPedido: 2,
                          modo: 1,
                          listaPedidos: _.listaPedidosCancelados),
                      // const ContenidoHistorial()
                    ]))
                  ],
                ),
              ),
            ));
  }
}
