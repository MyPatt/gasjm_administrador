import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/global_widgets/alert_rechazar.dart';
import 'package:gasjm/app/global_widgets/button_small.dart';
import 'package:gasjm/app/modules/detail/detail_controller.dart';
import 'package:get/get.dart';

class PedidosEnEsperaPage extends StatelessWidget {
  PedidosEnEsperaPage({Key? key, required this.idPedido}) : super(key: key);
  final controladorDePedidos = Get.put(DetailController());
  final String idPedido;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ButtonSmall(
              texto: "Rechazar",
              color: AppTheme.light,
              width: Responsive.getScreenSize(context).width * .39,
              onTap: () {
                _showDialogoParaRechazar(context, idPedido);
              }),
          ButtonSmall(
            texto: "Aceptar",
            width: Responsive.getScreenSize(context).width * .39,
            onTap: () =>
                controladorDePedidos.actualizarEstadoPedido(idPedido, 1),
          ),
/*
          Obx(() {
            final estadoProceso = controladorDePedidos.cargandoPedidos.value;
            return Stack(
              alignment: Alignment.center,
              children: [
                ButtonSmall(
                    texto: "Rechazar",
                    color: AppTheme.light,
                    width: Responsive.getScreenSize(context).width * .39,
                    onTap: () {
                      _showDialogoParaRechazar(context, idPedido);
                      /* _buildShowDialog(
                                                          context, controller.rechzarPedido(pedido.idPedido));*/
                    }),
                if (estadoProceso)
                  const CircularProgressIndicator(
                      backgroundColor: Colors.white),
              ],
            );
          }),
          Obx(() {
            final estadoProceso = controladorDePedidos.cargandoPedidos.value;
            return Stack(
              alignment: Alignment.center,
              children: [
                ButtonSmall(
                  texto: "Aceptar",
                  width: Responsive.getScreenSize(context).width * .39,
                  onTap: () => controladorDePedidos.actualizarEstadoPedido(
                      idPedido, "estado2"),
                ),
                if (estadoProceso)
                  const CircularProgressIndicator(
                      backgroundColor: Colors.white),
              ],
            );
          }),*/
        ],
      ),
    );
  }

  _showDialogoParaRechazar(BuildContext context, String id) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertRechazar(
            onPressed: () => _onrechazarPedidoEnEspera(context, id));
      },
    );
  }

  _onrechazarPedidoEnEspera(BuildContext context, String id) {
    print("Oobject");
    controladorDePedidos.actualizarEstadoPedido(id, 4);
    Navigator.of(context).pop();
  }
}
