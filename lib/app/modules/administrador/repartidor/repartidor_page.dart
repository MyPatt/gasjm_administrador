
import 'package:gasjm/app/global_widgets/bottom_administrador.dart';
import 'package:gasjm/app/global_widgets/custom_appbar.dart';
import 'package:gasjm/app/modules/administrador/repartidor/repartidor_controller.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/modules/administrador/repartidor/widgets/lista_repartidores.dart';

import 'package:get/get.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';

class RepartidorPage extends StatelessWidget {
  final RepartidorController controladorDeRepartidor =
      Get.put(RepartidorController());

  RepartidorPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.background,

        //
        appBar:   AppBar(
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10),
        ),
      ),
      backgroundColor: AppTheme.blueBackground,
      // actions: const [MenuAppBar()],
      title: const Text("Repartidores")) ,
        body: const ListaRepartidores(),
        //
        bottomNavigationBar:
            const BottomNavigationAdministrador(indiceActual: 2));
  }
}
