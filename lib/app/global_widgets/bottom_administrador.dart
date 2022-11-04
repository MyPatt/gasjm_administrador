import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/modules/home/home_controller.dart';
import 'package:get/get.dart';

class BottomNavigationAdministrador extends StatelessWidget {
  const BottomNavigationAdministrador({Key? key, required this.indiceActual}) : super(key: key);
  final int indiceActual ;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) => BottomNavigationBar(
        currentIndex: indiceActual,
        selectedItemColor: AppTheme.blueBackground,
        unselectedItemColor: Colors.black38,
        selectedLabelStyle: const TextStyle(color: Colors.black38),
        onTap: (index) {
          _.pantallaSeleccionadaOnTap(index, context);
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.show_chart_outlined), label: 'Reportes'),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_outlined),
              label: "Operaciones ",
              backgroundColor: AppTheme.blueBackground),
        ],
      ),
    );
  }
}
