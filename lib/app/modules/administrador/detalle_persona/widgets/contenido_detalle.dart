import 'package:gasjm/app/modules/administrador/detalle_persona/detalle_persona_controller.dart';
import 'package:gasjm/app/modules/administrador/detalle_persona/widgets/contenido_perfil.dart';
import 'package:gasjm/app/modules/administrador/detalle_persona/widgets/contenido_cliente.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//Obtener la pagina correspondiente segun el tipo de perfil de la persona

class ContenidoDetalle extends StatelessWidget {
  const ContenidoDetalle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //en caso del cliente se visualiza el perfil e historial, y en editar el perfil

    return GetBuilder<DetallePersonaController>(
        builder: (_) => (_.idPerfil == 'cliente')
            ? (_.clienteEditable
                ? const ContenidoPerfil()
                : const ContenidoVerCliente())
            :
            //para el caso del usuario actual y el repartidor se visualiza y edita el perfil
            const ContenidoPerfil());
  }
}
