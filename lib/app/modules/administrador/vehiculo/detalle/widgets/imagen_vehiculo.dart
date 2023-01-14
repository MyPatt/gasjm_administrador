import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/modules/administrador/vehiculo/detalle/detalle_controller.dart';
import 'package:get/get.dart';

class ImagenVehiculo extends StatelessWidget {
  const ImagenVehiculo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Center(
        child: CircleAvatar(
          radius: 75.0,
          backgroundColor: AppTheme.light,
          child: CircleAvatar(
            radius: 74.50,
            backgroundColor: Colors.white,
            child: GetBuilder<DetalleVehiculoController>(
              builder: (_) => 
              (Stack(children: [
                Obx(() => buildImage(_.existeImagenPerfil.value,
                    _.pickedImage.value, _.vehiculo.fotoVehiculo)),
                Positioned(
                  child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 14.0,
                      child: IconButton(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(3.0),
                        iconSize: 18.0,
                        icon: const Icon(
                          Icons.photo_camera,
                          color: AppTheme.light,
                        ),
                        onPressed: () {
                          _.cargarImagen();
                        },
                      )),
                  right: 5,
                  bottom: 5,
                )
              ])),
            ),
          ),
        ),
      ),
    );
  }

  // Builds Profile Image
  Widget buildImage(bool existeImagenPerfil, File? file, String? url) {
    final imagenInicio = existeImagenPerfil == true
        ? CircleAvatar(
            backgroundColor: AppTheme.light,
            radius: 70,
            backgroundImage: NetworkImage(url!))
        : const CircleAvatar(
            backgroundColor: AppTheme.light,
            radius: 70,
            child: CircleAvatar(
                backgroundColor: AppTheme.light,
                radius: 50,
                backgroundImage: AssetImage(
                  'assets/icons/placehoderperfil.png',
                )),
          );

    return file == null
        ? imagenInicio
        : CircleAvatar(
            backgroundColor: AppTheme.light,
            radius: 70,
            backgroundImage: FileImage(file));
  }
}
