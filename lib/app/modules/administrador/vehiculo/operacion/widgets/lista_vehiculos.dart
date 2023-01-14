import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/modules/administrador/vehiculo/operacion/operacion_controller.dart';
import 'package:gasjm/app/modules/administrador/vehiculo/operacion/widgets/card_vehiculo.dart';
import 'package:get/get.dart';

class ListaVehiculos extends StatelessWidget {
  const ListaVehiculos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OperacionVehiculoController>(
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
                          //Muestra la lista de vehiculos en caso de existir caso contrario texto de sin vehiculos
                          child: Obx(
                        () => !_.listaVehiculos.isNotEmpty
                            ? const Center(
                                child: TextDescription(text: "Sin vehículos!"))
                            : ListView(
                                children: _.listaVehiculos.map((vehiculo) {
                                  return CardVehiculo(
                                      vehiculo: vehiculo,
                                      editarDatosVehiculo: () =>
                                          _.editarDatosVehiculo(vehiculo),
                                      eliminarVehiculo: () =>
                                          _.eliminarVehiculo(
                                              vehiculo.idVehiculo!),
                                      verDatosVehiculo: () =>
                                          _.verDatosVehiculo(vehiculo));
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
