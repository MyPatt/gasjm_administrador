import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/data/controllers/pedido_controller.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/global_widgets/input_text.dart';
import 'package:gasjm/app/global_widgets/pedido/opciones_pedido.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
import 'package:get/get.dart';

class DetallePedido extends StatelessWidget {
  const DetallePedido(
      {Key? key, required this.e, required this.indiceCategoriaPedido})
      : super(key: key);
  final PedidoModel e;
  final int indiceCategoriaPedido;

  @override
  Widget build(BuildContext context) {
    final controlador = Get.put(PedidoController());

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
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: Responsive.hp(context) * 0.9,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 25),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  // alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextSubtitle(
                          text: e.nombreUsuario!,
                        ),
                        TextDescription(text: e.idCliente),
                        SizedBox(
                            height:
                                Responsive.getScreenSize(context).height * .03),
                        InputText(
                          initialValue: e.direccionUsuario,
                          iconPrefix: Icons.room_outlined,
                          labelText: "Dirección",
                          readOnly: true,
                          enabled: false,
                        ),

                        SizedBox(
                            height:
                                Responsive.getScreenSize(context).height * .02),
                        InputText(
                          iconPrefix: Icons.calendar_today_outlined,
                          initialValue:
                              controlador.formatoFecha(e.fechaHoraPedido),
                          labelText: "Fecha",
                          readOnly: true,
                          enabled: false,
                        ),
                        SizedBox(
                            height:
                                Responsive.getScreenSize(context).height * .02),
                        InputText(
                          initialValue: '${e.cantidadPedido}',
                          iconPrefix: Icons.pin_outlined,
                          labelText: "Cantidad",
                          readOnly: true,
                          enabled: false,
                        ),
                        SizedBox(
                            height:
                                Responsive.getScreenSize(context).height * .02),
                        InputText(
                          readOnly: true,
                          enabled: false,
                          initialValue: '${e.totalPedido}',
                          iconPrefix: Icons.attach_money_outlined,
                          labelText: "Total",
                        ),

                        SizedBox(
                            height:
                                Responsive.getScreenSize(context).height * .02),
                        InputText(
                          initialValue: '${e.notaPedido}',
                          iconPrefix: Icons.note_outlined,
                          labelText: "Nota",
                          readOnly: true,
                          enabled: false,
                        ),
                        SizedBox(
                            height:
                                Responsive.getScreenSize(context).height * .05),

                        //Tipo de categoria
                        OpcionesPedido(
                            e: e, indiceCategoriaPedido: indiceCategoriaPedido)
                      ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
