import 'package:flutter/material.dart';
import 'package:gasjm/app/modules/administrador/vehiculo/registrar/widget/form_vehiculo.dart';
import 'package:gasjm/app/modules/administrador/vehiculo/registrar/widget/imagen_vehiculo.dart';

class ContenidoDetalle extends StatelessWidget {
  const ContenidoDetalle({Key? key} ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 25),
                child: ListView(children: [
                  SizedBox(
                      height: 780.00,
                      child: LayoutBuilder(builder: (context, constraints) {
                        // double innerHeight = constraints.maxHeight;
                        double innerWidth = constraints.maxWidth;
                        return Stack(
                          children: <Widget>[
                            FormVehiculo(width: innerWidth),
                            const ImagenVehiculo()
                          ],
                        );
                      }))
                ])
          ),
        )));
  }
}
