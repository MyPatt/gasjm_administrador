import 'package:gasjm/app/data/models/persona_model.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
import 'package:gasjm/app/modules/cliente/cliente_controller.dart';
import 'package:gasjm/app/modules/cliente/widgets/search.dart'; 
import 'package:flutter/material.dart';
import 'package:gasjm/app/modules/operacion_pedido/pedido_controller.dart';

import 'package:get/get.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';

class ClientePage extends StatelessWidget {
  final ClienteController controladorDePedidos = Get.put(ClienteController());

  ClientePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OperacionPedidoController>(
        builder: (_) => Scaffold(
              backgroundColor: AppTheme.background,

              //
              appBar: AppBar(
                backgroundColor: AppTheme.blueBackground,
                // actions: const [MenuAppBar()],
                title: const Text("Clientes"),
              ),
              body: Stack(children: [
                Column(
                  children: [
                    const Search(),
                    Expanded(
                        child: Obx(
                      () => ListView(
                        children:
                            controladorDePedidos.listaFiltradaClientes.map((e) {
                          return _cardPedido(e, controladorDePedidos);
                        }).toList(),
                      ),
                    ))
                  ],
                )
              ]),
            ));
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