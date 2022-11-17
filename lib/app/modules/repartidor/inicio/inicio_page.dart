import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/global_widgets/bottom_repartidor.dart';
import 'package:gasjm/app/global_widgets/menu_lateral.dart';
import 'package:gasjm/app/modules/repartidor/inicio/inicio_controller.dart'; 
import 'package:gasjm/app/global_widgets/menu_appbar.dart';
import 'package:gasjm/app/modules/repartidor/inicio/widgets/navegacion_content.dart';
import 'package:get/get.dart';

//Pantalla de inicio del cliente
class InicioPage extends StatelessWidget {
  InicioPage({key}) : super(key: key);
  final controller = InicioController();
//
  @override
  Widget build(BuildContext context) {
    return GetBuilder<InicioController>(
        builder: (_) => Scaffold(
            //Menú deslizable a la izquierda con opciones del  usuario
            drawer: MenuLateral(
              modo: 'Modo administrador',
              imagenPerfil: _.imagenUsuario,
            ),
            //Barra de herramientas de opciones para  agenda y  historial
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
              title: const Text('GasJ&M'),
            ),
            //Body
            body: Stack(children: const [
              //Widget Mapa
              Positioned.fill(
               
                  child: ExplorarRepartidorPage()
             
                  )
            ]),
            //Navegacion del repartidor
            bottomNavigationBar: const BottomNavigationRepartidor(indiceActual: 0)));
  }
}
