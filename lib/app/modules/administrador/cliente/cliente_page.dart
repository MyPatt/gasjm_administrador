import 'package:gasjm/app/data/models/persona_model.dart';
import 'package:gasjm/app/global_widgets/bottom_administrador.dart';
import 'package:gasjm/app/global_widgets/menu_lateral.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
import 'package:gasjm/app/modules/administrador/cliente/cliente_controller.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/modules/administrador/cliente/widgets/contenido_lista.dart';
import 'package:gasjm/app/routes/app_routes.dart';

import 'package:get/get.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';

class ClientePage extends StatelessWidget {
  const ClientePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClienteController>(
        builder: (_) => Scaffold(
            backgroundColor: AppTheme.background,
            //Menú deslizable a la izquierda con opciones del  usuario
            drawer: MenuLateral(
                modo: 'Modo repartidor', imagenPerfil: _.imagenUsuario),

            //
            appBar: AppBar(
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
              ),
              backgroundColor: AppTheme.blueBackground,
              actions: [
                IconButton(
                    icon: const Icon(Icons.search_outlined),
                    onPressed: () => Get.toNamed(AppRoutes.buscarClienteAdmin)),
              ],
              title: const Text("Clientes"),
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
                                  eliminarCliente: ()   => _.eliminarCliente(persona.uidPersona!),
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

            //
            bottomNavigationBar:
                const BottomNavigationAdministrador(indiceActual: 2)));
  }
}
