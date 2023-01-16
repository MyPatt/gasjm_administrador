import 'package:flutter/material.dart';
import 'package:gasjm/app/modules/administrador/persona/registrar/widget/form_persona.dart';
import 'package:gasjm/app/modules/administrador/persona/registrar/widget/imagen_persona.dart';

class ContenidoRegistraPersona extends StatelessWidget {
  const ContenidoRegistraPersona({Key? key}) : super(key: key);

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
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 25),
              child: ListView(children: [
                SizedBox(
                    height: 780.00,
                    child: LayoutBuilder(builder: (context, constraints) {
                      double innerWidth = constraints.maxWidth;
                      return Stack(
                        children: <Widget>[
                          FormPersona(width: innerWidth),
                          const ImagenPersona()
                        ],
                      );
                    }))
              ])),
        )));
  }
}
