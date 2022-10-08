import 'package:flutter/material.dart'; 
import 'package:gasjm/app/core/theme/app_theme.dart';

class ImagenUsuario extends StatelessWidget {
  const ImagenUsuario({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircleAvatar(
        radius: 75.0,
        backgroundColor: AppTheme.light,
        child: CircleAvatar(
          radius: 74.50,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            child: Align(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 17.0,
                child: Icon(
                  Icons.camera_alt,
                  size: 20.0,
                  color: AppTheme.light,
                ),
              ),
            ),
            radius: 70.0,
            backgroundImage: AssetImage(
              'assets/icons/profile.png',
            ),
          ),
        ),
      ),
    );
  }
}
