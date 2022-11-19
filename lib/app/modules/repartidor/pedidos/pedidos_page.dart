import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/global_widgets/bottom_repartidor.dart';
import 'package:gasjm/app/global_widgets/menu_appbar.dart';
import 'package:gasjm/app/global_widgets/menu_lateral.dart';
import 'package:gasjm/app/global_widgets/pedido/contenido_pedido.dart';
import 'package:gasjm/app/modules/repartidor/pedidos/pedidos_controller.dart';
import 'package:gasjm/app/modules/historial/contenido_historial.dart'; 
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
              actions: const [
                MenuAppBar(
                  indiceMenu: 1,
                )
              ],
              title: const Text("Pedidos"),
            ),
            body: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: const TabBar(
                      indicatorColor: AppTheme.blueBackground,
                      labelColor: AppTheme.blueBackground,
                      unselectedLabelColor: AppTheme.light,
                      // indicator: BoxDecoration(color: Colors.white),
                      tabs: [
                        Tab(text: 'En espera'),
                        Tab(
                          text: 'Aceptados',
                        ),
                        Tab(text: "Finalizados")
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
                    ContenidoPedido(
                      indiceCategoriaPedido: 0,modo: 1,
                    ),
                    ContenidoPedido(
                      indiceCategoriaPedido: 1,modo: 1,
                    ),  ContenidoPedido(
                      indiceCategoriaPedido: 2,modo: 1,
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
