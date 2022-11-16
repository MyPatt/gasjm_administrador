import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/global_widgets/menu_appbar.dart';
import 'package:gasjm/app/global_widgets/menu_lateral.dart';
import 'package:gasjm/app/modules/repartidor/pedidos/pedidos_controller.dart';
import 'package:gasjm/app/modules/repartidor/pedidos/widgets/bottom_repartidor.dart';
import 'package:gasjm/app/modules/repartidor/pedidos/widgets/aceptados_page.dart';
import 'package:gasjm/app/modules/repartidor/pedidos/widgets/enespera_page.dart';
import 'package:get/get.dart';

class PedidosPage extends StatelessWidget {
  const PedidosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PedidosController>(
      builder: (_) => DefaultTabController(
          length: 2,
          child: Scaffold(
            //Menú deslizable a la izquierda con opciones del  usuario
            drawer: MenuLateral(
                modo: 'Modo administrador', imagenPerfil: _.imagenUsuario),

            //Barra de herramientas de opciones para  agenda y  historial
            appBar: AppBar(
              backgroundColor: AppTheme.blueBackground,
              actions: const [
                MenuAppBar(
                  indiceMenu: 1,
                )
              ],
              title: const Text('Pedidos'),
              bottom: const TabBar(
                indicatorColor: Colors.white,
                tabs: [
                  Tab(text: 'En espera'),
                  Tab(
                    text: 'Aceptados',
                  ),
                ],
              ),
            ),
            //Body
            body: TabBarView(
              children: [
                PedidosEnEsperaPage(),
                PedidosAceptadosPage(),
              ],
            ),
            //Navegacion del repartidor
            bottomNavigationBar: const BottomNavigationRepartidor(),
          )),
    );
  }
}
