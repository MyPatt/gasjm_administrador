import 'package:flutter/material.dart';
import 'package:gasjm/app/modules/administrador/pedido/registrar/widget/boton_pedirgas.dart';
import 'package:gasjm/app/modules/administrador/pedido/registrar/widget/content_map.dart'; 

class ContenidoRegistarPedido extends StatelessWidget {
  const ContenidoRegistarPedido({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          bottom: false,
          child: Stack(children: const <Widget>[
            //Widget Mapa
            Positioned.fill(
              child: ContentMap(),
            ),
            //

            //Widget Boton para pedir el gas
            BotonPedirGas(),
          ]),
        );
  }
}
