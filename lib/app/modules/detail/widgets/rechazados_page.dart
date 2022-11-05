import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/data/models/pedido_model.dart'; 
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
import 'package:gasjm/app/modules/detail/detail_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PedidosRechazadosPage extends StatelessWidget {
  final DetailController controladorDePedidos = Get.put(DetailController());
  double height = 0;

  PedidosRechazadosPage({Key? key, required this.idPedido}) : super(key: key);
  final String idPedido;
  @override
  Widget build(BuildContext context) {
    final _height = Responsive.getScreenSize(context).height * .02;
    height = _height;
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

 

  Future<void> _showDialogoParaVerDetalles(
      BuildContext context, PedidoModel pedido) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: const [
              TextSubtitle(
                text: 'Pedido: 001',
                textAlign: TextAlign.justify,
                // style: TextoTheme.subtitleStyle2,
              ),
              Divider(),
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.person_outline_outlined,
                      size: 18.0,
                      color: AppTheme.light,
                      semanticLabel: 'Cliente',
                    ),
                    TextDescription(
                      text: pedido.nombreUsuario ?? 'Cliente',

                      //style: TextoTheme.subtitleStyle2,
                    ),
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      TextDescription(
                          text: DateFormat('d/M/y')
                              .format(pedido.fechaHoraPedido.toDate())),
                      TextDescription(text: ' '),
                      TextDescription(
                          text: DateFormat.Hm()
                              .format(pedido.fechaHoraPedido.toDate()))
                    ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextDescription(
                        text: pedido.direccionUsuario ?? 'Sin ubicación'),
                    const TextDescription(text: '5 min')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextDescription(
                        text: 'Para ${pedido.diaEntregaPedido.toLowerCase()}'),
                    const TextDescription(text: '300m')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextDescription(
                      text: '${pedido.cantidadPedido} cilindros',
                      //style: TextoTheme.subtitleStyle2
                    ),
                    TextDescription(
                        text: 'Total: \$ ' + pedido.totalPedido.toString())
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextDescription(
                      text: "Repartidor: Freddy Bonilla",
                    ),
                  ],
                ),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.end,
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cerrar',
                style: TextStyle(
                  color: AppTheme.light,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<DropdownMenuItem<String>> _buildDropdownMenu(List<String> items) {
    List<DropdownMenuItem<String>> menuItems = [];
    for (var elemento in items) {
      menuItems.add(DropdownMenuItem(
          child: TextDescription(
            text: elemento,
          ),
          value: elemento));
    }
    return menuItems;
  }
}
