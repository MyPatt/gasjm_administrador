import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart'; 
import 'package:gasjm/app/modules/administrador/pedido/registrar/widget/contenido_registro.dart';

class RegistrarPedidoPage extends StatelessWidget {
  const RegistrarPedidoPage({
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
        title: const Text('Registrar vehículo'),
      ),
      body: const ContenidoRegistarPedido(),
      /*   bottomNavigationBar:
            const BottomNavigationAdministrador(indiceActual: 1)*/
    );
  }
}
