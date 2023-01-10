import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/modules/administrador/repartidor/repartidor_controller.dart';
import 'package:gasjm/app/modules/administrador/repartidor/widgets/card_persona.dart';
import 'package:get/get.dart';

class ListaRepartidores extends StatelessWidget {
  const ListaRepartidores({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RepartidorController>(
        builder: (_) => RefreshIndicator(
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
                          children: _.listaRepartidores.map((repartidor) {
                            return CardPersona(
                              persona: repartidor,
                              verDatosPersona: () =>_.verDetalleDelRepartidor(repartidor),
                              editarDatosPersona: () =>_.editarDetalleDelRepartidor(repartidor),
                              eliminarPersona: () =>_.eliminarRepartidor(repartidor.uidPersona!),
                            );
                          }).toList(),
                        ),
                      ))
                    ],
                  ),
                )
              ]),
            ));
  }
}
