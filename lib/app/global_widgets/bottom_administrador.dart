import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/global_widgets/modal_operaciones.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';

class BottomNavigationAdministrador extends StatelessWidget {
  const BottomNavigationAdministrador({Key? key, required this.indiceActual})
      : super(key: key);
  final int indiceActual;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: indiceActual,
      selectedItemColor: AppTheme.blueBackground,
      unselectedItemColor: Colors.black38,
      selectedLabelStyle: const TextStyle(color: Colors.black38),
      onTap: (index) async {
        await Future.delayed(const Duration(milliseconds: 500));
        switch (index) {
          case 0:
            Get.offNamed(AppRoutes.inicioAdministrador);
            break;
          case 1:
            showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) {
                  return ModalOperaciones(
                    indiceBottomItem: index,
                  );
                });
            break;
          case 2:
            showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) {
                  return ModalOperaciones(
                    indiceBottomItem: index,
                  );
                });
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.show_chart_outlined),
            label: 'Reportes',
            tooltip: 'Reportes'),
        BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'Crear',
            tooltip: 'Crear'),
        BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: "Operaciones ",
            backgroundColor: AppTheme.blueBackground,
            tooltip: 'Operaciones'),
      ],
    );
  }
}
