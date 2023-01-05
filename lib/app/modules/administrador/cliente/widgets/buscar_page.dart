import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/global_widgets/pedido/contenido_pedido.dart';
import 'package:gasjm/app/modules/administrador/buscar/buscar_controller.dart';
import 'package:gasjm/app/modules/administrador/buscar/widgets/buscar.dart';
import 'package:gasjm/app/modules/administrador/cliente/cliente_controller.dart';
import 'package:gasjm/app/modules/administrador/cliente/widgets/contenido_lista.dart';
import 'package:get/get.dart';

class BuscarClientePage extends StatelessWidget {
  const BuscarClientePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClienteController>(
        builder: (_) => Scaffold(
              backgroundColor: AppTheme.background,

              //
              appBar: AppBar(
                automaticallyImplyLeading: true,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(10),
                  ),
                ),
                backgroundColor: AppTheme.blueBackground,
                title: Buscar(
                  controller: _.controladorBuscarTexto,
                  onChanged: (String valor) => _.buscarPedidos(valor),
                  onTap: _.limpiarBusqueda,
                  existeTexoParaBuscar: _.existeTexoParaBuscar,
                ),
              ),
              body: RefreshIndicator(
                backgroundColor: Colors.white,
                color: AppTheme.blueBackground,
                displacement: 1,
                triggerMode: RefreshIndicatorTriggerMode.onEdge,
                onRefresh: _.pullRefrescar,
                child: Stack(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: Obx(
                            () => ListView(
                              children: _.listaClientes.map((persona) {
                                return ContenidoLista(
                                  persona: persona,
                                  onPressed: () =>
                                      _.cargarDetalleDelCliente(persona),
                                  eliminarCliente: () =>
                                      _.eliminarCliente(persona.uidPersona!),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
            ));
  }
}
