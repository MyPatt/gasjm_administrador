import 'package:flutter/material.dart';
import 'package:gasjm/app/global_widgets/bottom_administrador.dart';
import 'package:gasjm/app/global_widgets/menu_lateral.dart';
import 'package:gasjm/app/modules/administrador/vehiculo/operacion/operacion_controller.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/modules/administrador/vehiculo/operacion/widgets/lista_vehiculos.dart';
import 'package:get/get.dart';

class OperacionVehiculoPage extends StatelessWidget {
  const OperacionVehiculoPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.background,
        drawer: GetBuilder<OperacionVehiculoController>(
          builder: (_) => MenuLateral(
              modo: 'Modo repartidor', imagenPerfil: _.imagenPerfil),
        ),
        appBar: AppBar(
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),

          backgroundColor: AppTheme.blueBackground,
          // actions: const [MenuAppBar()],
          title: const Text('Vehículos'),
        ),
        body: const ListaVehiculos(),
        bottomNavigationBar:
            const BottomNavigationAdministrador(indiceActual: 2));
  }
}
