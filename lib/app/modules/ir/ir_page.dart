import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/global_widgets/menu_lateral.dart';
 
 import 'package:gasjm/app/global_widgets/repartidor/menu_appbar.dart';
import 'package:gasjm/app/modules/ir/ir_controller.dart';
import 'package:gasjm/app/modules/ir/widgets/bottom_repartidor.dart';
import 'package:gasjm/app/modules/ir/widgets/navegacion_content.dart';
import 'package:get/get.dart';

//Pantalla de inicio del cliente
class IrPage extends StatelessWidget {
  IrPage({key}) : super(key: key);
  final controller = IrController();
//
  @override
  Widget build(BuildContext context) {
    return GetBuilder<IrController>(
        builder: (_) => Scaffold(
            //Menú deslizable a la izquierda con opciones del  usuario
            drawer: const MenuLateral(),
            //Barra de herramientas de opciones para  agenda y  historial
            appBar: AppBar(
              backgroundColor: AppTheme.blueBackground,
              actions: const [MenuAppBar()],
              title: const Text('GasJ&M'),
            ),
            //Body
            body: Stack(children: const [
              //Widget Mapa
               Positioned.fill(
                // ignore: sized_box_for_whitespace
                child:
                IrRepartidorPage()
                /* Obx(() => _.listaPantallasBottomNavigation[
                    _.indexPantallaSeleccionada.value]['screen']),*/

                //
              )
            ]),
            //Navegacion del repartidor
            bottomNavigationBar: const BottomNavigationRepartidor()));
  }
}
