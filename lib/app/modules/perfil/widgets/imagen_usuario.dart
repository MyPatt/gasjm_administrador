 

import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/modules/perfil/perfil_controller.dart';
import 'package:image_picker/image_picker.dart';import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
class ImagenUsuario extends StatelessWidget {
   ImagenUsuario({Key? key}) : super(key: key);
 final userController = Get.find<PerfilController>();

  @override
  Widget build(BuildContext context) {
     final imageObx = Obx((){
      Widget image = Image.asset(
         'assets/icons/profile.png',
        fit: BoxFit.fill,
      );

      if (userController.pickedImage.value != null) {
        image = Image.file(
          userController.pickedImage.value,
          fit: BoxFit.fill,
        );
      } 
      /*else if (userController.user.value?.image?.isNotEmpty == true) {
        image = CachedNetworkImage(
          imageUrl: userController.user.value!.image!,
          progressIndicatorBuilder: (_, __, progress) =>
              CircularProgressIndicator(value: progress.progress),
          errorWidget: (_, __, ___) => const Icon(Icons.error),
          fit: BoxFit.fill,
        );
      }*/
      return image;
    });
    return GetBuilder<PerfilController>(
      builder: (_) => 
       Center(
        child: CircleAvatar(
          radius: 75.0,
          backgroundColor: AppTheme.light,
          child: CircleAvatar(
            radius: 74.50,
            backgroundColor: Colors.white,
            child: Obx(()=>
                CircleAvatar(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 17.0,
                      child: IconButton(
                        onPressed: () {
                          _.cargarImagen();
                        },
                        icon: Icon(
                          Icons.camera_alt,
                          size: 20.0,
                          color: AppTheme.light,
                        ),
                      )),
                ),
                radius: 70.0,
                backgroundImage:   FileImage(_.pickedImage.value)
                /*_.pickedImage.value!=null?
                   FileImage(_.pickedImage.value!):
                 AssetImage(
                  'assets/icons/profile.png',
                ),*/
              ),
            ),
          ),
        ),
      ),
    );
  }
}
