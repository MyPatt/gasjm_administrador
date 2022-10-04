import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/global_widgets/input_text.dart';
import 'package:gasjm/app/global_widgets/primary_button.dart';
import 'package:gasjm/app/modules/editar_cliente/editar_cliente_controller.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/validaciones.dart';
import 'package:get/get.dart';

class PerfilCliente extends StatelessWidget {
  const PerfilCliente({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 25),
      child: ListView(
        children: [
          SizedBox(
            height: 810.00,
            child: LayoutBuilder(
              builder: (context, constraints) {
                // double innerHeight = constraints.maxHeight;
                double innerWidth = constraints.maxWidth;
                return Stack(
                  //fit: StackFit.expand,
                  children: [
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: GetBuilder<EditarClienteController>(
                        builder: (_) => Container(
                          height: 740,
                          width: innerWidth,
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
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    SizedBox(
                                      height: 80,
                                    ),
                                    InputText(
                                      controller: _.cedulaTextoController,
                                      iconPrefix: Icons.credit_card,
                                      keyboardType: TextInputType.phone,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      validator: Validacion.validarCedula,
                                      labelText: "Cédula",
                                      onChanged: _.onChangedIdentificacion,
                                    ),
                                    SizedBox(
                                        height:
                                            Responsive.getScreenSize(context)
                                                    .height *
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
                                            Responsive.getScreenSize(context)
                                                    .height *
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
                                            Responsive.getScreenSize(context)
                                                    .height *
                                                .02),
                                    InputText(
                                      iconPrefix: Icons.email_outlined,
                                      keyboardType: TextInputType.emailAddress,
                                      labelText: "Correo electrónico",
                                      controller:
                                          _.correoElectronicoTextoController,
                                      validator:
                                          Validacion.validarCorreoElectronico,
                                    ),
                                    SizedBox(
                                        height:
                                            Responsive.getScreenSize(context)
                                                    .height *
                                                .02),

                                    InkWell(
                                      onTap: () {
                                        _.selectDate(context);
                                      },
                                      child: InputText(
                                        iconPrefix:
                                            Icons.calendar_month_outlined,
                                        labelText: "Fecha de nacimiento",
                                        enabled: false,
                                        keyboardType: TextInputType.datetime,
                                        controller:
                                            _.fechaNacimientoTextoController,
                                      ),
                                    ),

                                    SizedBox(
                                        height:
                                            Responsive.getScreenSize(context)
                                                    .height *
                                                .02),
                                    InputText(
                                      iconPrefix: Icons.phone_android_outlined,
                                      keyboardType: TextInputType.phone,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      labelText: "Celular",
                                      controller: _.celularTextoController,
                                      // validator: Validacion.validarApellido,
                                    ),
                                    SizedBox(
                                        height:
                                            Responsive.getScreenSize(context)
                                                    .height *
                                                .02),
                                    InputText(
                                      iconPrefix: Icons.room_outlined,
                                      labelText: "Dirección",
                                      controller: _.direccionTextoController,
                                      // validator: Validacion.validarApellido,
                                    ),

                                    SizedBox(
                                        height:
                                            Responsive.getScreenSize(context)
                                                    .height *
                                                .02),
                                    Obx(
                                      () => InputText(
                                        iconPrefix: Icons.lock_outlined,
                                        keyboardType: TextInputType.text,
                                        obscureText: _.contrasenaOculta.value,
                                        textInputAction: TextInputAction.done,
                                        controller: _.contrasenaTextoController,
                                        validator: Validacion.validarContrasena,
                                        maxLines: 1,
                                        labelText: "Contraseña",
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

                                    //
                                    SizedBox(
                                        height:
                                            Responsive.getScreenSize(context)
                                                    .height *
                                                .05),
                                    PrimaryButton(
                                        texto: "Guardar",
                                        onPressed: () {
                                          if (_.claveFormRegistrar.currentState
                                                  ?.validate() ==
                                              true) {
                                            //   _.registrarAdministrador();
                                          }
                                        }),
                                    //    Obx(() {
                                    // final estadoProceso = _.cargandoParaCorreo.value;
                                    // return
                                    /*  Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          PrimaryButton(
                                              texto: "Registrar",
                                              onPressed: () {
                                                if (_.claveFormRegistrar
                                                        .currentState
                                                        ?.validate() ==
                                                    true) {
                                                  //   _.registrarAdministrador();
                                                }
                                              }),*/
                                    /*  if (estadoProceso)
                            const CircularProgressIndicator(
                                backgroundColor: Colors.white),*/
                                    // ],
                                    //)
                                    // :}),
                                  ]),
                            );
                          }),
                        ),
                      ),
                    ),
                    /*   Positioned(
                      top: 110,
                      right: 20,
                      child: Icon(
                        AntDesign.setting,
                        color: Colors.grey[700],
                        size: 30,
                      ),
                    ),*/
                    const Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: CircleAvatar(
                          radius: 75.0,
                          backgroundColor: AppTheme.light,
                          child: CircleAvatar(
                            radius: 74.50,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 17.0,
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 20.0,
                                    color: AppTheme.light,
                                  ),
                                ),
                              ),
                              radius: 70.0,
                              backgroundImage: AssetImage(
                                'assets/icons/profile.png',
                              ),
                            ),
                          ),

                          /*
                          Image.asset(
                            'assets/icons/profile.png',
                            width: innerWidth * 0.45,
                            fit: BoxFit.fitWidth,
                          ),
                          */
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          SizedBox(
            height: 30,
          ),
          //TODO: mOSTRAR los pedidos
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
      */    SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
