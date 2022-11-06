import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/global_widgets/button_favorite.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
import 'package:gasjm/app/modules/operacion_pedido/pedido_controller.dart'; 
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PedidosAceptadosPage extends StatelessWidget {
     PedidosAceptadosPage({Key? key}) : super(key: key);
  final OperacionPedidoController controladorDePedidos = Get.put(OperacionPedidoController());
  double height = 0;



  @override
  Widget build(BuildContext context) {
    double _height = Responsive.getScreenSize(context).height * .02;
    height = _height;
    return Obx(() => RefreshIndicator(
        onRefresh: _pullRefrescar,
        child: Stack(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              /* Text(
                    'Data Game',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold),
                  ),*/
              /*
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      //Opcion para filtrar los pedidos en espera por dia
                      DropdownButton(
                          icon: const Icon(Icons.filter_alt_outlined,
                              color: AppTheme.light),
                          value: controladorDePedidos
                              .valorSeleccionadoItemDeFiltroAceptados.value,
                          items: _buildDropdownMenu(
                              controladorDePedidos.dropdownItemsDeFiltro),
                          onChanged: (String? value) {
                            controladorDePedidos
                                .valorSeleccionadoItemDeFiltroAceptados
                                .value = value ?? "";

                            controladorDePedidos
                                .cargarListaFiltradaDePedidosAceptados();
                          }),

                      //Opcion para ordenar los pedidos en espera por distintos categorias
                      DropdownButton(
                          icon: const Icon(Icons.arrow_drop_down_outlined,
                              color: AppTheme.light),
                          value: controladorDePedidos
                              .valorSeleccionadoItemDeOrdenamientoAceptados
                              .value,
                          items: _buildDropdownMenu(
                              controladorDePedidos.dropdownItemsDeOrdenamiento),
                          onChanged: (String? value) {
                            controladorDePedidos
                                .valorSeleccionadoItemDeOrdenamientoAceptados
                                .value = value ?? "";

                            //
                            controladorDePedidos
                                .ordenarListaFiltradaDePedidosAceptados();

                            // print(controladorDePedidos  .valorSeleccionadoItemDeOrdenamiento.value);
                          }),

                      //Cantidad de total de pedidos en espera
                      TextDescription(
                        text: controladorDePedidos
                            .listaFiltradaPedidosAceptados.length
                            .toString(),
                        textAlign: TextAlign.end,
                      ),
                      //TODO: Comprobar el ordenamiento de tiempo
                      //TODO: opcional - aceptar o rechazar pedidos seleccionados
                    ]),
              ),
              SizedBox(height: height),
              */
            /*  Expanded(
                  child: ListView(
                children:
                    controladorDePedidos.listaFiltradaPedidosAceptados.map((e) {
                  var index = controladorDePedidos.listaFiltradaPedidosAceptados
                      .indexOf(e);
                  index++;
                  return _cardPedido(e, context);
                }).toList(),
              ))*/
            ]),
          ),
        ])));
  }

  Widget _cardPedido(PedidoModel pedido, BuildContext context) {
    return Card(
      shape: Border.all(color: AppTheme.light, width: 0.5),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            /*Text(
                pedido.nombreUsuario ?? 'Cliente',
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  color: AppTheme.blueDark, fontWeight: FontWeight.w700),
            ),*/
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextSubtitle(
                  text: pedido.nombreUsuario ?? 'Cliente',
                  //style: TextoTheme.subtitleStyle2,
                ),
                TextSubtitle(
                  text: pedido.cantidadPedido.toString(),
                  //style: TextoTheme.subtitleStyle2
                )
              ],
            ),
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
                TextDescription(text: pedido.diaEntregaPedido),
                const TextDescription(text: '300m')
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TextDescription(
                  text: "Repartidor: Freddy Bonilla",
                ),
                ButtonFavorite(
                    child: TextDescription(
                      text: 'Ver detalles',
                      color: AppTheme.blueBackground,
                    ),
                    onTap: () => _showDialogoParaVerDetalles(context, pedido))

                /*  ButtonSmall(
                    texto: "Cancelar",
                    color: AppTheme.light,
                    width: Responsive.getScreenSize(context).width * .4,
                    onPressed: () {
                      _showDialogoParaRechazar(context, pedido.idPedido);
                    }),
               ButtonSmall(
                    texto: "Detalles",
                    width: Responsive.getScreenSize(context).width * .4,
                    onPressed: () =>
                        /* controladorDePedidos.actualizarEstadoPedidoAceptado(
                            pedido.idPedido,
                            "estado3",*/
                        Mensajes.showGetSnackbar(
                          titulo: "Mensaje",
                          mensaje: "Pedido finalizado con éxito,",
                          icono: const Icon(
                            Icons.check_circle_outline_outlined,
                            color: Colors.white,
                          ),
                        ))*/
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pullRefrescar() async {
  //  controladorDePedidos.cargarListaPedidosAceptados();
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
