import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/global_widgets/circular_progress.dart';
import 'package:gasjm/app/global_widgets/input_text.dart';
import 'package:gasjm/app/global_widgets/primary_button.dart';
import 'package:gasjm/app/modules/administrador/persona/detalle/detalle_persona_controller.dart';
import 'package:gasjm/app/core/utils/validaciones.dart';
import 'package:get/get.dart';

class FormPersona extends StatelessWidget {
  const FormPersona({Key? key, required, required this.width})
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
      child: GetBuilder<DetallePersonaController>(
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
              key: _.claveFormRegistrar,
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //
                    InputText(
                      controller: _.cedulaTextoController,
                      iconPrefix: Icons.credit_card,
                      readOnly: true,
                      enabled: false,
                      labelText: "Cédula",
                    ),
                    SizedBox(
                        height: Responsive.getScreenSize(context).height * .02),
                    InputText(
                      iconPrefix: Icons.person_outlined,
                      keyboardType: TextInputType.name,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                      ],
                      labelText: "Nombre",
                      controller: _.nombreTextoController,
                      validator: Validacion.validarNombre,
                      enabled: _.clienteEditable,
                    ),
                    SizedBox(
                        height: Responsive.getScreenSize(context).height * .02),
                    InputText(
                      iconPrefix: Icons.person_outlined,
                      keyboardType: TextInputType.name,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                      ],
                      labelText: "Apellido",
                      controller: _.apellidoTextoController,
                      enabled: _.clienteEditable,
                      validator: Validacion.validarApellido,
                    ),
                    SizedBox(
                        height: Responsive.getScreenSize(context).height * .02),
                    InputText(
                      iconPrefix: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      labelText: "Correo electrónico",
                      textCapitalization: TextCapitalization.none,
                      controller: _.correoElectronicoTextoController,
                      validator: Validacion.validarCorreoElectronico,
                      enabled: false,
                    ),
                    SizedBox(
                        height: Responsive.getScreenSize(context).height * .02),
                    InkWell(
                      onTap: () {
                        if (_.clienteEditable == true) {
                          _.seleccionaFechaNacimiento(context);
                        }
                      },
                      child: InputText(
                        iconPrefix: Icons.calendar_month_outlined,
                        labelText: "Fecha de nacimiento",
                        enabled: false,
                        keyboardType: TextInputType.datetime,
                        controller: _.fechaNacimientoTextoController,
                      ),
                    ),
                    SizedBox(
                        height: Responsive.getScreenSize(context).height * .02),
                    InputText(
                      iconPrefix: Icons.phone_android_outlined,
                      keyboardType: TextInputType.phone,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      labelText: "Celular",
                      enabled: _.clienteEditable,
                      controller: _.celularTextoController,
                      // validator: Validacion.validarApellido,
                    ),
                    SizedBox(
                        height: Responsive.getScreenSize(context).height * .02),
                    InputText(
                      iconPrefix: Icons.room_outlined,
                      labelText: "Dirección",
                      enabled: false,
                      controller: _.direccionTextoController,
                      // validator: Validacion.validarApellido,
                    ),
                    SizedBox(
                        height: Responsive.getScreenSize(context).height * .05),
                    Obx(() {
                      final estadoProceso = _.cargandoCliente.value;
                      return Visibility(
                        visible: _.clienteEditable,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Visibility(
                              visible: !_.cargandoCliente.value,
                              child: PrimaryButton(
                                  texto: "Actualizar",
                                  onPressed: () {
                                    if (_.claveFormRegistrar.currentState
                                            ?.validate() ==
                                        true) {
                                      _.actualizarCliente();
                                    }
                                  }),
                            ),
                            if (estadoProceso) const CircularProgress()
                          ],
                        ),
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

