import 'package:gasjm/app/global_widgets/bottom_administrador.dart';
import 'package:gasjm/app/global_widgets/menu_appbar.dart';
import 'package:gasjm/app/modules/detail/detail_controller.dart';
import 'package:gasjm/app/modules/detail/widgets/aceptados_page.dart';
import 'package:flutter/material.dart';
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

            //
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: AppTheme.blueBackground,
              actions: const [
                MenuAppBar(
                  indiceMenu: 1,
                )
              ],
              title: const Text("Pedidos"),
              /*    bottom: TabBar(
                isScrollable: true,
                indicatorColor: AppTheme.blueBackground,
                //labelColor: AppTheme.blueDark,
                // indicator: BoxDecoration(color: Colors.white),
                tabs: [
                  Tab(text: 'En espera'),
                  Tab(text: 'Aceptados'),
                  Tab(
                    text: 'Finalizados',
                  ),
                  Tab(
                    text: 'Cancelados',
                  ),
                ],
              ),*/
            ),
            body: DefaultTabController(
              length: 5,
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: const TabBar(
                      isScrollable: true,
                      indicatorColor: AppTheme.blueBackground,
                      labelColor: AppTheme.blueBackground,
                      unselectedLabelColor: AppTheme.light,
                      // indicator: BoxDecoration(color: Colors.white),
                      tabs: [
                        Tab(text: 'Todos'),
                        Tab(text: 'En espera'),
                        Tab(text: 'Aceptados'),
                        Tab(
                          text: 'Finalizados',
                        ),
                        Tab(
                          text: 'Cancelados',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: TabBarView(children: [
                    PedidosAFinalizadosPage(),
                    PedidosAceptadosPage(),
                    PedidosAceptadosPage(),
                    PedidosAFinalizadosPage(),
                    PedidosAFinalizadosPage()
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
