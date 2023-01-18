import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/modules/administrador/persona/detalle/detalle_persona_controller.dart';
import 'package:get/get.dart';

class ImagenPersona extends StatelessWidget {
  const ImagenPersona({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Center(
        child: CircleAvatar(
          backgroundColor: AppTheme.light,
          radius: 75.0,
          child: GetBuilder<DetallePersonaController>(
            builder: (_) => CircleAvatar(
              radius: 74.50,
              backgroundColor: Colors.white,
              child: (_.cliente.fotoPersona ?? '').length > 5
                  ? CircleAvatar(
                      backgroundColor: AppTheme.light,
                      radius: 70.0,
                      backgroundImage: NetworkImage(_.cliente.fotoPersona!))
                  : const CircleAvatar(
                      backgroundColor: AppTheme.light,
                      radius: 70.0,
                      child: CircleAvatar(
                          backgroundColor: AppTheme.light,
                          radius: 50.0,
                          backgroundImage: AssetImage(
                            'assets/icons/placehoderperfil.png',
                          )),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
