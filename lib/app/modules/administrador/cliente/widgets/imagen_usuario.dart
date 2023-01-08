import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';

class ImagenUsuario extends StatelessWidget {
  const ImagenUsuario({Key? key, required this.urlfotoPerfil})
      : super(key: key);

  final String urlfotoPerfil;

  @override
  Widget build(BuildContext context) {
    return (Padding(
      padding: const EdgeInsets.all(16.0),
      child: buildImage(urlfotoPerfil),
    ));
  }

  // Builds Profile Image
  Widget buildImage(String url) {
    final imagenInicio = url.length > 5
        ? CircleAvatar(
            backgroundColor: AppTheme.light,
            radius: 25,
            backgroundImage: NetworkImage(url))
        : const CircleAvatar(
            backgroundColor: AppTheme.light,
            radius: 25,
            child: CircleAvatar(
                backgroundColor: AppTheme.light,
                radius: 15,
                backgroundImage: AssetImage(
                  'assets/icons/placehoderperfil.png',
                )),
          );

    return imagenInicio;
  }
}
 