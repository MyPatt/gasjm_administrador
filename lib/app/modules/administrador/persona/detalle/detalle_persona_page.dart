import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/modules/administrador/persona/detalle/detalle_persona_controller.dart';
import 'package:gasjm/app/modules/administrador/persona/detalle/widgets/contenido_detalle.dart'; 
import 'package:get/get.dart';

class DetallePersonaPage extends StatelessWidget {
  const DetallePersonaPage({key}) : super(key: key);
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
            title: GetBuilder<DetallePersonaController>(
              builder: (_) => Text(
                  '${_.cliente.nombrePersona} ${_.cliente.apellidoPersona}'),
            )),
        body: const ContenidoDetalle());
  }
}
