import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/modules/editar_cliente/editar_cliente_controller.dart';
import 'package:gasjm/app/modules/editar_cliente/widgets/perfil_cliente.dart';
import 'package:get/get.dart';

class EditarClientePage extends StatelessWidget {
  const EditarClientePage({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditarClienteController>(
      builder: (_) => Scaffold(
        backgroundColor: AppTheme.background,
        appBar: AppBar(
          backgroundColor: AppTheme.blueBackground,
          // actions: const [MenuAppBar()],
          title: const Text('Editar cliente'),
          actions: [
            //Eliminar cliente
            IconButton(
                onPressed: () {
                  
                }, icon: const Icon(Icons.delete_outlined)),
          ],
        ),
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top,
                child: const PerfilCliente()),
          ),
        ),
      ),
    );
  }
}
