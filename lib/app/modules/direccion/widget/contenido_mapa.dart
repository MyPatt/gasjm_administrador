import 'package:flutter/material.dart';
import 'package:gasjm/app/global_widgets/circular_progress.dart';
import 'package:gasjm/app/modules/direccion/direccion_controller.dart';
import 'package:gasjm/app/modules/direccion/widget/form_direccion.dart';
import 'package:gasjm/app/modules/perfil/perfil_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ContenidoMapa extends StatelessWidget {
  const ContenidoMapa({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DirecccionController>(
      builder: (_) => Positioned.fill(
          child: Column(
        children: [
          FormDireccion(
            controladorDeTexto: _.direccionAuxTextoController,
          ),
          Expanded(
              child: FutureBuilder(
            future: _.agregarMarcadorCliente(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Obx(() => GoogleMap(
                      mapType: MapType.normal,
                      markers: Set.of(_.marcadores),
                      initialCameraPosition: CameraPosition(
                          /*  target: LatLng(
                                    _.usuario.direccionPersona?.latitud ?? 0,
                                    _.usuario.direccionPersona?.longitud ?? 0)*/
                          target: _.posicionAuxCliente.value,
                          zoom: 15.0),
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
                      onMapCreated: _.onMapaCreado,
                      onCameraMove: _.onCameraMove,
                      onCameraIdle: () async {
                        _.getMovimientoCamara();
                      },
                    ));
              } else {
                return const CircularProgress();
              }
            },
          ))
        ],
      )),
    );
  }
}
