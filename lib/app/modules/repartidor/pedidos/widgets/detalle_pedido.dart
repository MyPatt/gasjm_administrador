import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
import 'package:gasjm/app/modules/operacion_pedido/pedido_controller.dart';
import 'package:gasjm/app/modules/operacion_pedido/widgets/enespera_page.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class DetallePedido extends StatelessWidget {
  DetallePedido({Key? key, required this.e}) : super(key: key);
  final PedidoModel e;
  final OperacionPedidoController controladorDePedidos =
      Get.put(OperacionPedidoController());

  @override
  Widget build(BuildContext context) {
    List<Step> steps = [
      Step(
        title: Obx(
          () => Text(
            'Pedido realizado',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: controladorDePedidos.currentStep.value == 0
                    ? AppTheme.blueDark
                    : AppTheme.light,
                fontWeight: controladorDePedidos.currentStep.value == 0
                    ? FontWeight.bold
                    : FontWeight.w500),
          ),
        ),
        subtitle: Text(
          controladorDePedidos.formatoFecha(e.fechaHoraPedido),
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.light,
                fontWeight: FontWeight.w500,
              ),
        ),
        isActive: controladorDePedidos.activeStep1.value,
        content: Container(),
      ),
      Step(
        title: Obx(
          () => Text(
            'Pedido aceptado',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: controladorDePedidos.currentStep.value == 1
                    ? AppTheme.blueDark
                    : AppTheme.light,
                fontWeight: controladorDePedidos.currentStep.value == 1
                    ? FontWeight.bold
                    : FontWeight.w500),
          ),
        ),
        subtitle: Text(
          controladorDePedidos.formatoFecha(
              e.estadoPedido1?.fechaHoraEstado ?? Timestamp.now()),
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.light,
                fontWeight: FontWeight.w500,
              ),
        ),
        content: Container(),
        isActive: controladorDePedidos.activeStep2.value,
      ),
      Step(
        title: Text('Pedido en camino',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppTheme.light,
                )),
        content: Container(),
        isActive: false,
      ),
      Step(
        title: Text('Pedido finalizado',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppTheme.light,
                )),
        content: Container(),
        state: StepState.complete,
        isActive: false,
      ),
    ];
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        backgroundColor: AppTheme.blueBackground,
        title: const Text(
          "Detalle del pedido",
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            controladorDePedidos.currentStep.value = 0;
            controladorDePedidos.activeStep1.value = true;
            controladorDePedidos.activeStep2.value = false;
            Get.back();
          },
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              height: Responsive.hp(context) * 0.9,
              child: ListView(children: [
                ///
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.nombreUsuario ?? 'Cliente',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      color: AppTheme.blueDark,
                                      fontWeight: FontWeight.w800),
                            ),
                            SizedBox(height: 5.0),
                            Row(
                              children: [
                                Icon(
                                  Icons.credit_card_outlined,
                                  size: 15.0,
                                ),
                                SizedBox(width: 10.0),
                                Text(
                                  e.idCliente,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                        color: AppTheme.blueDark,
                                      ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.0),
                            Row(
                              children: [
                                Icon(
                                  Icons.room_outlined,
                                  size: 16.0,
                                ),
                                SizedBox(width: 10.0),
                                Text(
                                  e.direccionUsuario ?? 'Sin ubicación',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                        color: AppTheme.blueDark,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            CircleAvatar(
                                backgroundColor: AppTheme.blueBackground,
                                radius: 20.0,
                                child: TextSubtitle(
                                  text: e.cantidadPedido.toString(),
                                  color: Colors.white,
                                )
                                /*  child: Icon(
                              Icons.person_outline_outlined,
                              size: 23.0,
                            ),*/
                                ),
                            Text(
                              "\$ ${e.totalPedido.toStringAsFixed(2)}",
                              textAlign: TextAlign.justify,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: AppTheme.blueDark,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      //"Barrio Santa Rosa a una cuadra del parque, puerta negra.",
                      e.notaPedido ?? "",
                      textAlign: TextAlign.justify,
                      maxLines: 3,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppTheme.light,
                          ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      '300 m',
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppTheme.light,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      '5 min',
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppTheme.light,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    SizedBox(height: 10.0),
                    const Divider(
                      thickness: 1,
                    ),
                    Obx(
                      () => Theme(
                        data: Theme.of(context).copyWith(
                            colorScheme: Theme.of(context).colorScheme.copyWith(
                                onSurface: AppTheme.light,
                                primary: AppTheme.light)),
                        /*  Theme.of(context).copyWith(
                          
                            colorScheme: const ColorScheme.light(
                              primary: Colors.grey,

                              //onSurface: AppTheme.blueDark,
                            )),*/
                        child: Stepper(
                          controlsBuilder:
                              (BuildContext ctx, ControlsDetails dtl) {
                            return Row(
                              children: [Container()],
                            );
                          },
                          currentStep: controladorDePedidos.currentStep.value,
                          steps: steps,
                          type: StepperType.vertical,
                          onStepContinue: () {
                            print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                          },
                          /*  onStepTapped: (step) {
                                //  setState(() {
                                current_step = step;
                              },
                              onStepContinue: () {
                                //  setState(() {
                                if (current_step < steps.length - 1) {
                                  current_step = current_step + 1;
                                } else {
                                  current_step = 0;
                                }
                                //   });
                              },
                              onStepCancel: () {
                                //   setState(() {
                                if (current_step > 0) {
                                  current_step = current_step - 1;
                                } else {
                                  current_step = 0;
                                }
                                //  });
                              },*/
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    const Divider(
                      thickness: 1.0,
                    ),
                    SizedBox(height: 10.0),
                    PedidosEnEsperaPage(idPedido: e.idPedido)
                  ]),
                ),
                /*  const Spacer(),
                  Container(
                      margin:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                      child: PedidosEnEsperaPage(idPedido: e.idPedido))*/
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
