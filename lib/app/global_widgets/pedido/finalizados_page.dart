import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/data/controllers/pedido_controller.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PedidosAFinalizadosPage extends StatelessWidget {
  final controladorDePedidos = Get.put(PedidoController());

  PedidosAFinalizadosPage({Key? key, required this.idPedido}) : super(key: key);
  final String idPedido;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const <Widget>[
            TextDescription(
              text: "Repartidor: Freddy Bonilla",
            ),
          ],
        ));
  }
}
