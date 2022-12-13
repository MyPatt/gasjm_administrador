import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/data/controllers/pedido_controller.dart';
import 'package:gasjm/app/global_widgets/modal_alert.dart';
import 'package:gasjm/app/global_widgets/button_small.dart';
import 'package:get/get.dart';

class PedidosAceptadosPage extends StatelessWidget {
      PedidosAceptadosPage({Key? key, required this.idPedido, required this.modo, required this.idCliente})
      : super(key: key);
  final PedidoController controladorDePedidos = Get.put(PedidoController());
  final String idPedido;
  final String idCliente;
  final int modo;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ButtonSmall(
              texto: "Cancelar",
              color: AppTheme.light,
              width: Responsive.getScreenSize(context).width * .4,
              onTap: () {
                _showDialogoParaCancelar(context, idPedido);
              }),
          ButtonSmall(
            texto: "Finalizar",
            width: Responsive.getScreenSize(context).width * .4,
            onTap: () =>
                controladorDePedidos.actualizarEstadoPedido(idPedido, 2, modo,idCliente),
          )
        ],
      ),
    );
  }

  _showDialogoParaCancelar(BuildContext context, String id) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ModalAlert(
            titulo: 'Cancelar pedido',
            mensaje: '¿Está seguro de cancelar el pedido?',
            icono: Icons.error_outline,
            onPressed: () => _onCancelarPedidoAceptado(context, id));
      },
    );
  }

  _onCancelarPedidoAceptado(BuildContext context, String id) {
    controladorDePedidos.actualizarEstadoPedido(id, 3, modo,idCliente);
    Navigator.of(context).pop();
  }
}
