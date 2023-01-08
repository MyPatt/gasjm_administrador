import 'package:flutter/material.dart';
import 'package:gasjm/app/modules/administrador/editar_cliente/editar_cliente_controller.dart';
import 'package:gasjm/app/modules/administrador/editar_cliente/widgets/perfil_cliente.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ContenidoPerfil extends StatelessWidget {
  const ContenidoPerfil();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditarClienteController>(
        builder: (_) => SafeArea(
              bottom: false,
              child: SingleChildScrollView(
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top,
                    child: PerfilCliente(
                      urlfotoPerfil: _.cliente.fotoPersona ?? '',
                      clienteEditable: _.clienteEditable,
                    )),
              ),
            ));
  }
}
