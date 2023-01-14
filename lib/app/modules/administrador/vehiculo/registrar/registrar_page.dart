import 'package:flutter/material.dart'; 
import 'package:gasjm/app/modules/administrador/vehiculo/registrar/widget/contenido_crear.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';

class RegistrarVehiculoPage extends StatelessWidget {
  const RegistrarVehiculoPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.background,
        appBar: AppBar(
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          backgroundColor: AppTheme.blueBackground,
          // actions: const [MenuAppBar()],
          title: const Text('Registrar vehículo'),
        ),
        body: const ContenidoCrear(),
     /*   bottomNavigationBar:
            const BottomNavigationAdministrador(indiceActual: 1)*/
            );
  }
}