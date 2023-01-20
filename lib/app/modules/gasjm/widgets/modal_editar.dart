import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/core/utils/validaciones.dart';

import 'package:gasjm/app/global_widgets/circular_progress.dart';
import 'package:gasjm/app/global_widgets/input_text.dart';
import 'package:gasjm/app/global_widgets/primary_button.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
import 'package:gasjm/app/modules/gasjm/gasjm_controller.dart';
import 'package:get/get.dart';
//Bottom dialog  modal para editar el celulafr y el precio de producto de info del gasjm

class ModalEditarGasJm extends StatelessWidget {
  const ModalEditarGasJm({Key? key, required this.nombreDato})
      : super(key: key);
  final String nombreDato;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GasJMController>(
        builder: (_) => Container(
            height: Responsive.hp(context) * 0.5,
            width: double.infinity,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 5,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: GetBuilder<GasJMController>(
                builder: (_) => Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Container(
                              width: 50.0,
                              height: 5.0,
                              margin: const EdgeInsets.only(bottom: 25.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                          TextSubtitle(
                            text: 'Editar $nombreDato',
                          ),
                          const TextDescription(text: "Ingrese los datos"),
                          SizedBox(
                              height: Responsive.getScreenSize(context).height *
                                  .03),
                          Visibility(
                            visible: nombreDato == 'celular',
                            child: InputText(
                              iconPrefix: Icons.phone_android_outlined,
                              keyboardType: TextInputType.phone,
                              inputFormatters: <TextInputFormatter>[
                                LengthLimitingTextInputFormatter(10),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              labelText: "Celular",
                              controller: _.celularTextoController,
                              validator: Validacion.validarCelularObligatorio,
                            ),
                          ),
                          Visibility(
                            visible: nombreDato == 'producto',
                            child: InputText(
                              iconPrefix: Icons.attach_money_outlined,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              inputFormatters: <TextInputFormatter>[
                                LengthLimitingTextInputFormatter(4),
                                // FilteringTextInputFormatter.digitsOnly,
                              ],
                              labelText: "Producto",
                              controller: _.precioTextoController,
                              validator: Validacion.validarPrecioProducto,
                            ),
                          ),
                          SizedBox(
                              height: Responsive.getScreenSize(context).height *
                                  .05),
                          Obx(() {
                            final estadoGuardar =
                                _.actualizandoDistribuidora.value;
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                Visibility(
                                  visible: !_.actualizandoDistribuidora.value,
                                  child: PrimaryButton(
                                    texto: "Guardar",
                                    onPressed: () {
                                      switch (nombreDato) {
                                        case 'celular':
                                          _.actualizarCelular();
                                          break;
                                        case 'producto':
                                          _.actualizarPrecioProducto();
                                          Navigator.pop(context);
                                          break;
                                      }
                                    },
                                  ),
                                ),
                                if (estadoGuardar) const CircularProgress()
                              ],
                            );
                          }),
                          SizedBox(
                              height: Responsive.getScreenSize(context).height *
                                  .03),
                        ]))));
  }
}
