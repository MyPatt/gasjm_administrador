import 'package:flutter/material.dart'; 

import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/modules/administrador/persona/registrar/registrar_controller.dart';
import 'package:gasjm/app/modules/administrador/persona/registrar/widget/contenido_crear.dart';
import 'package:get/get.dart';

class RegistrarPersonaPage extends StatelessWidget {
  const RegistrarPersonaPage({
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
          title: GetBuilder<RegistrarPersonaController>(
        builder: (_) =>
              Text('Registrar ${_.perfil}')
          ),
        ),
        body: const ContenidoRegistraPersona(),
     /*   bottomNavigationBar:
            const BottomNavigationAdministrador(indiceActual: 1)*/
            );
  }
}