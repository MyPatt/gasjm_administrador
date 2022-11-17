import 'package:gasjm/app/data/models/categoria_model.dart';
import 'package:gasjm/app/global_widgets/bottom_administrador.dart';
import 'package:gasjm/app/global_widgets/menu_appbar.dart';
import 'package:gasjm/app/global_widgets/menu_lateral.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/global_widgets/pedido/contenido_pedido.dart';
import 'package:gasjm/app/modules/operacion_pedido/pedido_controller.dart';

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
              actions: const [
                MenuAppBar(
                  indiceMenu: 1,
                )
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
                      tabs: categoriasPedidos
                          .map((e) => Tab(
                                text: e.name,
                              ))
                          .toList(),
                    ),
                  ),
                  Expanded(
                      child: TabBarView(children: [
                    ContenidoPedido(
                      indiceCategoriaPedido: 0,
                    ),
                    ContenidoPedido(
                      indiceCategoriaPedido: 1,
                    ),
                    ContenidoPedido(
                      indiceCategoriaPedido: 2,
                    ),
                    ContenidoPedido(
                      indiceCategoriaPedido: 3,
                    ),
                  ]))
                ],
              ),
            ),
            bottomNavigationBar:
                const BottomNavigationAdministrador(indiceActual: 1)));
  }
}
