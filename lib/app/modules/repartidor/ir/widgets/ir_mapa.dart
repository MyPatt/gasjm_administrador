import 'package:flutter/material.dart';
import 'package:gasjm/app/global_widgets/circular_progress.dart';
import 'package:gasjm/app/modules/repartidor/ir/ir_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class IrMapa extends StatelessWidget {
  const IrMapa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = IrController();
    //Evento en el marcker clic
    controller.onMarcadorTap.listen((id) {
      //print("solo por probar $id");
    });
    //
    return GetBuilder<IrController>(
        builder: (_) => Obx(
              () => _.posicionInicialRepartidor.value ==
                      const LatLng(-0.2053476, -79.4894387)
                  ? const Center(child: CircularProgress())
                  : GoogleMap(
                      markers: _.marcadoresParaIr,
                      onMapCreated: _.onMapaCreated,
                      initialCameraPosition: CameraPosition(
                          target: _.posicionInicialRepartidor.value, zoom: 15),
                      myLocationButtonEnabled: true,
                      compassEnabled: true,
                      zoomControlsEnabled: false,
                      zoomGesturesEnabled: true,
                      mapToolbarEnabled: false,
                      trafficEnabled: false,
                      tiltGesturesEnabled: false,
                      scrollGesturesEnabled: true,
                      rotateGesturesEnabled: false,
                      myLocationEnabled: true,
                      liteModeEnabled: false,
                      indoorViewEnabled: false,
                    ),
            ));
  }
}
//TODO: Boton para regresar a la ubicacion inicial