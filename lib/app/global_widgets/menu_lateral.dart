import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/data/controllers/autenticacion_controller.dart';
import 'package:gasjm/app/global_widgets/modal_alert.dart';
import 'package:gasjm/app/global_widgets/dialogs/progress_dialog.dart';
import 'package:gasjm/app/global_widgets/primary_button.dart';

import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Menú deslizable a la izquierda con opciones del  usuario
class MenuLateral extends StatelessWidget {
  const MenuLateral({key, required this.modo, required this.imagenPerfil})
      : super(key: key);
  final String modo;
  final RxString imagenPerfil;

  @override
  Widget build(BuildContext context) {
    var usuario =
        Get.find<AutenticacionController>().autenticacionUsuario.value?.nombre;

    return Drawer(
        child: Container(
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _buildDrawerHeader(imagenPerfil),
          const SizedBox(
            height: 15,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              usuario ?? '',
              style: const TextStyle(
                  color: AppTheme.blueDark, fontWeight: FontWeight.w500),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              modo == 'Modo administrador' ? 'Repartidor' : 'Administrador',
              style: const TextStyle(color: Colors.black38),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          _buildDrawerItem(
              icon: Icons.person_outline,
              text: 'Mi cuenta',
              onTap: () => Get.toNamed(AppRoutes.perfil)),
          _buildDrawerItem(
              icon: Icons.manage_accounts_outlined,
              text: 'Gas J&M',
              onTap: () {
                if (modo == 'Modo administrador') {
                  Get.toNamed(AppRoutes.gasjm, arguments: 1);
                  return;
                } else {
                  Get.toNamed(AppRoutes.gasjm, arguments: 0);
                }
              }),
          _buildDrawerItem(
              icon: Icons.settings_outlined,
              text: 'Configuración',
              onTap: () => {
                    Navigator.pushReplacementNamed(context, AppRoutes.ubicacion)
                  }),
          _buildDrawerItem(
              icon: Icons.help_outline,
              text: 'Ayuda',
              onTap: () => {
                    Navigator.pushReplacementNamed(context, AppRoutes.registrar)
                  }),
          _buildDrawerItem(
            icon: Icons.exit_to_app_outlined,
            text: 'Cerrar sesión',
            onTap: () async {
              return showDialog<void>(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return ModalAlert(
                    onPressed: () async {
                      ProgressDialog.show(context, "Cerrando sesión");

                      Get.find<AutenticacionController>().cerrarSesion();
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.remove("cedula_usuario");
                      await prefs.clear();
                    },
                    titulo: 'Cerrar sesión',
                    mensaje: '¿Está seguro de cerrar sesión en la aplicación?',
                    icono: Icons.exit_to_app_outlined,
                  );
                },
              );
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .19),
          PrimaryButton(
            texto: modo,
            onPressed: () async {
              ProgressDialog.show(context, "Cargando...");
              await Future.delayed(const Duration(seconds: 2));

              if (modo == 'Modo administrador') {
                Get.offAllNamed(AppRoutes.inicioAdministrador);
                return;
              } else {
                Get.offAllNamed(AppRoutes.inicioRepartidor);
              }
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .05),
        ],
      ),
    ));
  }
}

Widget _buildDrawerHeader(RxString imagenPerfil) {
  return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide.none, top: BorderSide.none)),
      child: Stack(children: [
        Container(
          margin: const EdgeInsets.only(bottom: 48),
          height: 150,
          decoration: const BoxDecoration(
            color: AppTheme.blueBackground,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Obx(
            () => CircleAvatar(
                radius: 40.0,
                backgroundColor: Colors.white,
                child: (imagenPerfil.isEmpty)
                    ? const CircleAvatar(
                        backgroundColor: AppTheme.light,
                        radius: 38.0,
                        child: CircleAvatar(
                            backgroundColor: AppTheme.light,
                            radius: 35.0,
                            backgroundImage: AssetImage(
                              'assets/icons/placehoderperfil.png',
                            )),
                      )
                    : CircleAvatar(
                        backgroundColor: AppTheme.light,
                        radius: 38.0,
                        backgroundImage: NetworkImage(imagenPerfil.value))),
          ),
        ),
      ]));
}

Widget _buildDrawerItem(
    {IconData? icon, String? text, GestureTapCallback? onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(
          icon,
          color: Colors.black38,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            text!,
            style: const TextStyle(color: Colors.black38),
          ),
        )
      ],
    ),
    onTap: onTap,
  );
}
