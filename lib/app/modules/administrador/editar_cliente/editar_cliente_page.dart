import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/modules/administrador/editar_cliente/editar_cliente_controller.dart';
import 'package:gasjm/app/modules/administrador/editar_cliente/widgets/perfil_cliente.dart';
import 'package:get/get.dart';

class EditarClientePage extends StatelessWidget {
  EditarClientePage({key}) : super(key: key);
  final EditarClienteController controladorDePedidos =
      Get.put(EditarClienteController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditarClienteController>(
      builder: (_) => Scaffold(
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
          title: Text(_.clienteEditable ? 'Editar cliente' : 'Cliente'),
        ),
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top,
                child: PerfilCliente(
                  clienteEditable: _.clienteEditable,
                  urlfotoPerfil: _.cliente.fotoPersona ?? '',
                )),
          ),
        ),
      ),
    );
  }
}
