import 'package:flutter/material.dart';
import 'package:gasjm/app/global_widgets/primary_button.dart';
import 'package:gasjm/app/modules/direccion/direccion_controller.dart';
import 'package:get/get.dart';

class BotonSeleccionar extends StatelessWidget {
  const BotonSeleccionar({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DirecccionController>(
        builder: (_) => Visibility(
              visible: _.permisoParaEditarMapa,
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 30.0),
                      child: PrimaryButton(
                          texto: "Guardar",
                          onPressed: () {
                            _.actualizarNuevaDireccion();
                            Navigator.pop(context);
                          }))),
            ));
  }
}
