import 'package:gasjm/app/data/models/persona_model.dart';
import 'package:gasjm/app/global_widgets/bottom_administrador.dart';
import 'package:gasjm/app/global_widgets/menu_lateral.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
import 'package:gasjm/app/modules/administrador/cliente/cliente_controller.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/modules/administrador/cliente/widgets/contenido_lista.dart';

import 'package:get/get.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';

class ClientePage extends StatelessWidget {
  final ClienteController controladorDePedidos = Get.put(ClienteController());

  ClientePage({
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
              // actions: const [MenuAppBar()],
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
                            children: controladorDePedidos.listaFiltradaClientes
                                .map((persona) {
                              return ContenidoLista(
                                  persona: persona,
                                  onPressed: () =>
                                      _.cargarDetalleDelCliente(persona));
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

Widget _cardPedido(
    PersonaModel persona, ClienteController controladorDePedidos) {
  return Padding(
    padding:
        const EdgeInsets.only(right: 8.0, left: 8.0, top: 4.0, bottom: 4.0),
    child: Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(color: AppTheme.light, width: 0.5),
      ),
      child: ListTile(
        style: ListTileStyle.list,
        iconColor: AppTheme.light,
        leading: const Icon(
          Icons.person_outlined,
          //  size: 30,
        ),
        title: TextSubtitle(
          text: '${persona.nombrePersona} ${persona.apellidoPersona}',
          textAlign: TextAlign.justify,
        ),
        subtitle: TextDescription(
            text: persona.cedulaPersona, textAlign: TextAlign.justify),
        trailing: IconButton(
            onPressed: () {
              controladorDePedidos.cargarDetalleDelCliente(persona);
            },
            icon: const Icon(
              Icons.keyboard_arrow_right_outlined,
              // size: 30,
            )),
      ),
    ),
  );
}
