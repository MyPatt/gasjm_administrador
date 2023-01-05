import 'package:gasjm/app/data/models/persona_model.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
import 'package:gasjm/app/modules/administrador/repartidor/repartidor_controller.dart'; 
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';

class RepartidorPage extends StatelessWidget {
  final RepartidorController controladorDeRepartidor =
      Get.put(RepartidorController());

  RepartidorPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RepartidorController>(
        builder: (_) => Scaffold(
              backgroundColor: AppTheme.background,

              //
              appBar: AppBar(
                backgroundColor: AppTheme.blueBackground,
                // actions: const [MenuAppBar()],
                title: const Text("Repartidores"),
              ),
              body: Stack(children: [
                Column(
                  children: [ 
                    Expanded(
                        child: Obx(
                      () => ListView(
                        children: controladorDeRepartidor
                            .listaFiltradaRepartidores
                            .map((e) {
                          return _cardRepartidor(e, controladorDeRepartidor);
                        }).toList(),
                      ),
                    ))
                  ],
                )
              ]),
            ));
  }
}

Widget _cardRepartidor(
    PersonaModel persona, RepartidorController controladorDePedidos) {
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
              controladorDePedidos.cargarDetalleDelRepartidor(persona);
            },
            icon: const Icon(
              Icons.keyboard_arrow_right_outlined,
              // size: 30,
            )),
      ),
    ),
  );
}
