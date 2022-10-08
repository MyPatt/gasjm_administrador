import 'package:flutter/material.dart';
import 'package:gasjm/app/global_widgets/input_text.dart';
import 'package:gasjm/app/modules/perfil/perfil_controller.dart';
import 'package:flutter/services.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/global_widgets/primary_button.dart';
import 'package:gasjm/app/core/utils/validaciones.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';

class FormUsuario extends StatelessWidget {
  const FormUsuario({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PerfilController>(
      builder: (_) => Container(
        height: 790,
        //  width: innerWidth,
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
                  InputText(
                    controller: _.cedulaTextoController,
                    iconPrefix: Icons.credit_card,
                    keyboardType: TextInputType.phone,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: Validacion.validarCedula,
                    labelText: "Cédula",
                  ),
                  SizedBox(
                      height: Responsive.getScreenSize(context).height * .02),
                  InputText(
                    iconPrefix: Icons.person_outlined,
                    keyboardType: TextInputType.name,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                    ],
                    labelText: "Nombre",
                    controller: _.nombreTextoController,
                    validator: Validacion.validarNombre,
                  ),
                  SizedBox(
                      height: Responsive.getScreenSize(context).height * .02),
                  InputText(
                    iconPrefix: Icons.person_outlined,
                    keyboardType: TextInputType.name,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                    ],
                    labelText: "Apellido",
                    controller: _.apellidoTextoController,
                    validator: Validacion.validarApellido,
                  ),
                  SizedBox(
                      height: Responsive.getScreenSize(context).height * .02),
                  InputText(
                    iconPrefix: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    labelText: "Correo electrónico",
                    controller: _.correoElectronicoTextoController,
                    validator: Validacion.validarCorreoElectronico,
                  ),
                  SizedBox(
                      height: Responsive.getScreenSize(context).height * .02),

                  InkWell(
                    onTap: () {
                      _.selectDate(context);
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
                    controller: _.celularTextoController,
                     validator: Validacion.validarCelular,
                  ),
                  SizedBox(
                      height: Responsive.getScreenSize(context).height * .02),
                  InputText(
                    iconPrefix: Icons.room_outlined,
                    labelText: "Dirección",
                    controller: _.direccionTextoController,
                    // validator: Validacion.validarApellido,
                  ),

                  SizedBox(
                      height: Responsive.getScreenSize(context).height * .04),
                  GestureDetector(
                    child: Text(
                      "Cambiar contraseña",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          ?.copyWith(color: Colors.black54),
                    ),
                    onTap: () => Get.toNamed(AppRoutes.contrasena),
                  ),

                  //
                  SizedBox(
                      height: Responsive.getScreenSize(context).height * .05),

                  Obx(() {
                    final estadoProceso = _.cargandoParaCorreo.value;
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        PrimaryButton(
                            texto: "Guardar",
                            onPressed: () {
                              if (_.claveFormRegistrar.currentState
                                      ?.validate() ==
                                  true) {
                                _.actualizarCliente();
                              }
                            }),
                        if (estadoProceso)
                          const CircularProgressIndicator(
                              backgroundColor: Colors.white),
                      ],
                    );
                  }),
                ]),
          );
        }),
      ),
    );
  }
}
