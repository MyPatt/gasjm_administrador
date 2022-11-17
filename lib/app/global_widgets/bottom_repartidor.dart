import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';

class BottomNavigationRepartidor extends StatelessWidget {
  const BottomNavigationRepartidor({Key? key, required this.indiceActual})
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
            Get.offNamed(AppRoutes.inicioRepartidor);
            break;
          case 1:
            Get.offNamed(AppRoutes.ir);
            break;
          case 2:
            Get.offNamed(AppRoutes.pedidos);
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.room_outlined,
            ),
            label: 'Explorar'),
        BottomNavigationBarItem(
            icon: Icon(Icons.mode_of_travel_outlined),
            label: "Ir ",
            backgroundColor: AppTheme.blueBackground),
        BottomNavigationBarItem(
            icon: Icon(Icons.list_outlined), label: "Pedidos ")
      ],
    );
  }
}
