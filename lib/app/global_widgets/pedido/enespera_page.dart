import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/global_widgets/modal_alert.dart';
import 'package:gasjm/app/global_widgets/button_small.dart';
import 'package:gasjm/app/data/controllers/pedido_controller.dart';

import 'package:get/get.dart';

class PedidosEnEsperaPage extends StatelessWidget {
  PedidosEnEsperaPage({Key? key, required this.idPedido, required this.modo, required this.idCliente}) : super(key: key);
  final controladorDePedidos = Get.put(PedidoController());
  final String idPedido;
  final int modo;
  final String idCliente;
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
                controladorDePedidos.actualizarEstadoPedido(idPedido, 1,modo,idCliente),
          ),
        ],
      ),
    );
  }

  _showDialogoParaRechazar(BuildContext context, String id) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ModalAlert(
          onPressed: () => _onrechazarPedidoEnEspera(context, id),
          titulo: 'Rechazar pedido',
          mensaje: '¿Está seguro de rechazar el pedido?',
          icono: Icons.cancel_outlined,
        );
      },
    );
  }

  _onrechazarPedidoEnEspera(BuildContext context, String id) {
    controladorDePedidos.actualizarEstadoPedido(id, 4,modo,idCliente);
    Navigator.of(context).pop();
  }
}
