import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/global_widgets/circular_progress.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
import 'package:gasjm/app/modules/administrador/editar_cliente/editar_cliente_controller.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class ContenidoHistorial extends StatelessWidget {
  const ContenidoHistorial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditarClienteController>(
        builder: (_) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 25),
              child: Obx(
                () => _.cargandoPedidos.value
                    ? const Center(child: CircularProgress())
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Obx(() => !_
                                      .listaPedidosRealizados.isNotEmpty
                                  ? const Center(
                                      child:
                                          TextDescription(text: "Sin pedidos!"))
                                  : buildListView(_.listaPedidosRealizados)))
                        ],
                      ),
              ),
              /* ListView(
                children: [
                  //

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          TextSubtitle(text: 'Finalizados'),
                          TextDescription(text: '2')
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
                          TextSubtitle(text: 'Cancelados'),
                          TextDescription(text: '0')
                        ],
                      ),
                    ],
                  ),
                  //

          */
            )));
  }

  /////////////////

  ListView buildListView(List<PedidoModel> lista) {
    String? prevDay;
    String today = DateFormat("d MMMM, y", "es").format(DateTime.now());
    String yesterday = DateFormat("d MMMM, y", "es")
        .format(DateTime.now().add(const Duration(days: -1)));

    return ListView.builder(
      itemCount: lista.length,
      itemBuilder: (context, index) {
        PedidoModel transaction = lista[index];
        DateTime date = DateTime.fromMillisecondsSinceEpoch(
            transaction.fechaHoraPedido.millisecondsSinceEpoch
            // controlador.listaFechas[index].millisecondsSinceEpoch
            //transactions[index].createdMillis!.toInt()
            );
        String dateString = DateFormat("d MMMM, y", "es").format(date);

        if (today == dateString) {
          dateString = "Hoy";
        } else if (yesterday == dateString) {
          dateString = "Ayer";
        }

        bool showHeader = prevDay != dateString;
        prevDay = dateString;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            showHeader
                ? Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Text(
                      dateString,
                      //  '${controlador.listaFechas[index].toDate()}',
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: AppTheme.blueDark,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  )
                : const Offstage(),
            buildItem(index, context, date, transaction),
          ],
        );
      },
    );
  }

  Widget buildItem(
      int index, BuildContext context, DateTime date, PedidoModel transaction) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(width: 20),
          buildLine(index, context),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            // color: Theme.of(context).accentColor,
            child: Text(
              DateFormat("HH:mm").format(date),
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    color: AppTheme.light,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Expanded(
            flex: 1,
            child: buildItemInfo(transaction, context),
          ),
        ],
      ),
    );
  }

  Card buildItemInfo(PedidoModel pedido, BuildContext context) {
    final EditarClienteController controlador =
        Get.put(EditarClienteController());

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      //  shape: Border.all(color: AppTheme.light, width: 0.5),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
                onTap: () => controlador.cargarDetalle(
                      pedido,
                    ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextSubtitle(
                          text: '${pedido.direccionUsuario}',
                        ),
                        TextSubtitle(text: '${pedido.cantidadPedido}')
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextDescription(
                            text: pedido.estadoPedidoUsuario ?? 'Finalizado'),
                        TextDescription(text: '\$ ${pedido.totalPedido}')
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Container buildLine(int index, BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              width: 2,
              color: AppTheme.blueBackground,
            ),
          ),
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
                color: AppTheme.blueBackground, shape: BoxShape.circle),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: 2,
              color: AppTheme.blueBackground,
            ),
          ),
        ],
      ),
    );
  }
}
