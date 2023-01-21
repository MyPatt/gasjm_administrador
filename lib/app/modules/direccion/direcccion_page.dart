import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/modules/direccion/direccion_controller.dart';
import 'package:gasjm/app/modules/direccion/widget/boton_seleccionar.dart';
import 'package:gasjm/app/modules/direccion/widget/contenido_mapa.dart';
import 'package:get/get.dart';

class DireccionPage extends StatelessWidget {
  const DireccionPage({Key? key}) : super(key: key);

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
          automaticallyImplyLeading: true,
          title: const Text("Dirección"),
        ),
        body: SafeArea(
            bottom: false,
            child:
            
Get.find<DirecccionController>().permisoParaEditarMapa?

             Stack(children: const <Widget>[
              ContenidoMapa(),
              BotonSeleccionar()
            ])
            :
            const      ContenidoMapa()
            ));
  }
}
