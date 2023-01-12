import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/global_widgets/circular_progress.dart';
import 'package:gasjm/app/global_widgets/input_text.dart';
import 'package:gasjm/app/global_widgets/primary_button.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/core/utils/validaciones.dart';
import 'package:gasjm/app/modules/administrador/vehiculo/registrar/registrar_controller.dart';

import 'package:get/get.dart';

class FormVehiculo extends StatelessWidget {
  const FormVehiculo({Key? key, required, required this.width})
      : super(key: key);
  final double width;

  @override
  Widget build(BuildContext context) {
    /*  double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;*/
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: GetBuilder<RegistrarVehiculoController>(
        builder: (_) => Container(
          height: 680,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          // alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: LayoutBuilder(builder: (context, constraint) {
            return Form(
              key: _.claveFormRegistrarVehiculo,
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //
                    InputText(
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(7),
                      ],
                      controller: _.placaTextoController,
                      iconPrefix: Icons.directions_car_outlined,
                      validator: Validacion.validarNombre,
                      labelText: "Placa",
                      textCapitalization: TextCapitalization.characters,
                    ),
                    SizedBox(
                        height: Responsive.getScreenSize(context).height * .02),
                    InputText(
                      labelText: "Marca",
                      iconPrefix: Icons.branding_watermark_outlined,
                      keyboardType: TextInputType.name,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                      ],
                      controller: _.marcaTextoController,
                      validator: Validacion.validarNombre,
                    ),
                    SizedBox(
                        height: Responsive.getScreenSize(context).height * .02),
                    InputText(
                      labelText: "Modelo",
                      iconPrefix: Icons.abc_outlined,
                      controller: _.modeloTextoController,
                      validator: Validacion.validarNombre,
                    ),
                    SizedBox(
                        height: Responsive.getScreenSize(context).height * .02),
                    InputText(
                      labelText: "Año",
                      iconPrefix: Icons.drag_indicator,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(4),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      controller: _.anioTextoController,
                      validator: Validacion.validarAnio,
                    ),
                    SizedBox(
                        height: Responsive.getScreenSize(context).height * .02),
                    Row(
                      children: [
                        const Icon(Icons.person_outline_outlined,
                            size: 20.0, color: AppTheme.light),
                        SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: Obx(() => DropdownButton(
                                hint: const Text(
                                  'Repartidor',
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 14.0,
                                      height: 2),
                                ),
                                value: _.dropdownRepartidorInicial.value,
                                items: _.items.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                /* items: _.listaRepartidores
                                    .map((e) => DropdownMenuItem(
                                        value: e.uidPersona,
                                        child: Text(e.uidPersona ?? 'l'
                                            //'${e.nombrePersona} ${e.apellidoPersona}'
                                            )))
                                    .toList(),
                                onChanged: (String? nuevoValor) {
                                  if (nuevoValor != null) {
                                    _.dropdownRepartidorInicial.value =
                                        nuevoValor;
                                    print(nuevoValor);
                                  }
                                }),*/
                                onChanged: (String? newValue) {
                                  print(newValue);
                                  // dropdownvalue = newValue!;
                                },
                              )),
                        ),
                      ],
                    ),

                    SizedBox(
                        height: Responsive.getScreenSize(context).height * .02),
                    InputText(
                      labelText: "Observación",
                      iconPrefix: Icons.note_outlined,
                      controller: _.observacionTextoController,
                    ),

                    Obx(() => Visibility(
                        visible:
                            _.errorParaDatosVehiculo.value?.isNotEmpty == true,
                        child: Column(
                          children: [
                            SizedBox(
                                height:
                                    Responsive.getScreenSize(context).height *
                                        .02),
                            TextDescription(
                              text: _.errorParaDatosVehiculo.value ?? '',
                              color: Colors.red,
                            ),
                          ],
                        ))),

                    SizedBox(
                        height: Responsive.getScreenSize(context).height * .05),
                    Obx(() {
                      final estadoProceso = _.cargandoVehiculo.value;
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Visibility(
                            visible: !_.cargandoVehiculo.value,
                            child: PrimaryButton(
                                texto: 'Registrar',
                                onPressed: () {
                                  if (_.claveFormRegistrarVehiculo.currentState
                                          ?.validate() ==
                                      true) {
                                    _.registrarVehiculo();
                                  }
                                }),
                          ),
                          if (estadoProceso) const CircularProgress()
                        ],
                      );
                    }),
                  ]),
            );
          }),
        ),
      ),
    );
  }
}
                  

          //TODO: Borrar cliente diseno
          /*    Container(
            //height: height * 0.5,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'My Orders',
                    style: TextStyle(
                      color: Color.fromRGBO(39, 105, 171, 1),
                      fontSize: 27,
                      fontFamily: 'Nunito',
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Orders',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontFamily: 'Nunito',
                              fontSize: 25,
                            ),
                          ),
                          Text(
                            '10',
                            style: TextStyle(
                              color: Color.fromRGBO(39, 105, 171, 1),
                              fontFamily: 'Nunito',
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 8,
                        ),
                        child: Container(
                          height: 50,
                          width: 3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            'Pending',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontFamily: 'Nunito',
                              fontSize: 25,
                            ),
                          ),
                          Text(
                            '1',
                            style: TextStyle(
                              color: Color.fromRGBO(39, 105, 171, 1),
                              fontFamily: 'Nunito',
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 2.5,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: height * 0.15,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: height * 0.15,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
      */

