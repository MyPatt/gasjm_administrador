import 'package:gasjm/app/data/models/categoria_model.dart';
import 'package:gasjm/app/global_widgets/bottom_administrador.dart';
import 'package:gasjm/app/global_widgets/menu_appbar.dart';
import 'package:gasjm/app/global_widgets/menu_lateral.dart';
import 'package:gasjm/app/modules/detail/detail_controller.dart';
import 'package:gasjm/app/modules/detail/widgets/aceptados_page.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/modules/detail/widgets/contenido_pedido.dart';
import 'package:gasjm/app/modules/detail/widgets/finalizados_page.dart';

import 'package:get/get.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailController>(
        builder: (_) => Scaffold(
            backgroundColor: AppTheme.background,
            //Menú deslizable a la izquierda con opciones del  usuario
            drawer: MenuLateral(
                modo: 'Modo repartidor',
                foto: Obx(
                  () => buildImage(_.imagenUsuario.value),
                )),

            //
            appBar: AppBar(
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
                      indiceCategoriaPedido: 0,
                    ),
                    ContenidoPedido(
                      indiceCategoriaPedido: 0,
                    ),

                    /* PedidosAceptadosPage(),
                    PedidosAFinalizadosPage(),
                    PedidosAFinalizadosPage()*/
                  ]))
                ],
              ),
            ),
            bottomNavigationBar:
                const BottomNavigationAdministrador(indiceActual: 1)));
  }
}

Widget buildImage(String? imagenPerfil) {
  return imagenPerfil == null
      ? const CircleAvatar(
          backgroundColor: AppTheme.light,
          radius: 38.0,
          child: CircleAvatar(
              backgroundColor: AppTheme.light,
              radius: 35.0,
              backgroundImage: AssetImage(
                'assets/icons/placehoderperfil.png',
              )),
        )
      : CircleAvatar(
          backgroundColor: AppTheme.light,
          radius: 38.0,
          backgroundImage: NetworkImage(imagenPerfil));
}
