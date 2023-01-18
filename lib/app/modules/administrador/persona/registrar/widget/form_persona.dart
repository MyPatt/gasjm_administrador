import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/global_widgets/circular_progress.dart';
import 'package:gasjm/app/global_widgets/input_text.dart';
import 'package:gasjm/app/global_widgets/primary_button.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/core/utils/validaciones.dart';
import 'package:gasjm/app/modules/administrador/persona/registrar/registrar_controller.dart';

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
      child: GetBuilder<RegistrarPersonaController>(
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
            return Obx(() => AbsorbPointer(
                  absorbing: _.cargandoPersona.value,
                  child: Form(
                    key: _.claveFormRegistrarPersona,
                    child: CustomScrollView(slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                  height:
                                      Responsive.getScreenSize(context).height *
                                          .05),
                              //
                              InputText(
                                controller: _.cedulaTextoController,
                                iconPrefix: Icons.credit_card,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(10),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                validator: Validacion.validarCedula,
                                labelText: "Cédula",
                              ),
                              SizedBox(
                                  height:
                                      Responsive.getScreenSize(context).height *
                                          .02),
                              InputText(
                                iconPrefix: Icons.person_outlined,
                                keyboardType: TextInputType.name,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[a-zA-Z]')),
                                ],
                                labelText: "Nombre",
                                controller: _.nombreTextoController,
                                validator: Validacion.validarNombre,
                              ),
                              SizedBox(
                                  height:
                                      Responsive.getScreenSize(context).height *
                                          .02),
                              InputText(
                                iconPrefix: Icons.person_outlined,
                                keyboardType: TextInputType.name,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[a-zA-Z]')),
                                ],
                                labelText: "Apellido",
                                controller: _.apellidoTextoController,
                                validator: Validacion.validarApellido,
                              ),
                              SizedBox(
                                  height:
                                      Responsive.getScreenSize(context).height *
                                          .02),
                              InputText(
                                iconPrefix: Icons.email_outlined,
                                keyboardType: TextInputType.emailAddress,
                                textCapitalization: TextCapitalization.none,
                                labelText: "Correo electrónico",
                                controller: _.correoElectronicoTextoController,
                                validator: Validacion.validarCorreoElectronico,
                              ),
                              SizedBox(
                                  height:
                                      Responsive.getScreenSize(context).height *
                                          .02),

                              InkWell(
                                onTap: () {
                                  _.seleccionarFechaDeNacimiento(context);
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
                                  height:
                                      Responsive.getScreenSize(context).height *
                                          .02),
                              InputText(
                                iconPrefix: Icons.phone_android_outlined,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(10),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                labelText: "Celular",
                                controller: _.celularTextoController,
                              ),

                              SizedBox(
                                  height:
                                      Responsive.getScreenSize(context).height *
                                          .05),
                              Obx(
                                () => InputText(
                                  iconPrefix: Icons.lock_outlined,
                                  keyboardType: TextInputType.text,
                                  obscureText: _.contrasenaOculta.value,
                                  textInputAction: TextInputAction.done,
                                  controller: _.contrasenaTextoController,
                                  validator: Validacion.validarContrasena,
                                  labelText: "Contraseña",
                                  maxLines: 1,
                                  suffixIcon: GestureDetector(
                                    onTap: _.mostrarContrasena,
                                    child: Icon(
                                      _.contrasenaOculta.value
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: AppTheme.light,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height:
                                      Responsive.getScreenSize(context).height *
                                          .02),
                              Obx(() => Visibility(
                                  visible: _.errorParaDatosPersona.value
                                          ?.isNotEmpty ==
                                      true,
                                  child: TextDescription(
                                    text: _.errorParaDatosPersona.value ?? '',
                                    color: Colors.red,
                                  ))),

                              SizedBox(
                                  height:
                                      Responsive.getScreenSize(context).height *
                                          .05),
                              Obx(() {
                                final estadoProceso = _.cargandoPersona.value;
                                return Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Visibility(
                                      visible: !_.cargandoPersona.value,
                                      child: PrimaryButton(
                                          texto: "Registrar",
                                          onPressed: () {
                                          
                                            if (_.claveFormRegistrarPersona
                                                    .currentState
                                                    ?.validate() ==
                                                true) {
                                              _.registrarPersona(context);
                                            }
                                          }),
                                    ),
                                    if (estadoProceso) const CircularProgress(),
                                  ],
                                );
                              }),
                              //
                            ]),
                      ),
                    ]),
                  ),
                ));
          }),
        ),
      ),
    );
  }
}
