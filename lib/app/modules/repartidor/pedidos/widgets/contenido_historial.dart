import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/data/models/historial_model.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ContenidoHistorial extends StatelessWidget {
  const ContenidoHistorial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? prevDay;
    String today = DateFormat("d MMM, y").format(DateTime.now());
    String yesterday = DateFormat("d MMM, y")
        .format(DateTime.now().add(const Duration(days: -1)));

    return
        /* Obx(
      () =>*/
        RefreshIndicator(
      backgroundColor: Colors.white,
      color: AppTheme.blueBackground,
      displacement: 1,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      onRefresh: _pullRefrescar,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                    child: ListView.builder(
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    Transaction transaction = transactions[index];
                    DateTime date = DateTime.fromMillisecondsSinceEpoch(
                        transaction.createdMillis!.toInt());
                    String dateString = DateFormat("d MMM, y").format(date);

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
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
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
                )),
              ],
            ),
          ),
        ],
      ),
      // ),
    );
  }

  Future<void> _pullRefrescar() async {
    //controladorDePedidos.listaPedidosXCategoria("estado1").value;
    // controladorDePedidos.cargarListaPedidos(indiceCategoriaPedido);
    await Future.delayed(const Duration(seconds: 2));
  }

/*
ListView(
                      children: (indiceCategoriaPedido == 0
                              ? controladorDePedidos.listaPedidosEnEspera.value
                              : indiceCategoriaPedido == 1
                                  ? controladorDePedidos
                                      .listaPedidosAceptados.value
                                  : indiceCategoriaPedido == 2
                                      ? controladorDePedidos
                                          .listaPedidosFinalizados.value
                                      : controladorDePedidos
                                          .listaPedidosCancelados.value)
                          .map((e) {
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
                                    onTap: () => Get.to(DetallePedido(
                                        e: e,
                                        indiceCategoriaPedido:
                                            indiceCategoriaPedido)),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            TextSubtitle(
                                              text:
                                                  e.nombreUsuario ?? 'Cliente',
                                              // style: TextoTheme.subtitleStyle2,
                                            ),
                                            TextSubtitle(
                                              text: e.cantidadPedido.toString(),
                                              //  style: TextoTheme.subtitleStyle2
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            TextDescription(
                                                text: e.direccionUsuario ??
                                                    'Sin ubicación'),
                                            const TextDescription(text: '5 min')
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            TextDescription(
                                                text: controladorDePedidos
                                                    .formatoFecha(
                                                        e.fechaHoraPedido)),
                                            const TextDescription(text: '300 m')
                                          ],
                                        ),
                                      ],
                                    )),
                                const Divider(),
                                //Tipo de categoria
                                OpcionesPedido(
                                    e: e,
                                    indiceCategoriaPedido:
                                        indiceCategoriaPedido)
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                 
*/
  Widget buildItem(
      int index, BuildContext context, DateTime date, Transaction transaction) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(width: 20),
          buildLine(index, context),
          /*  Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            // color: Theme.of(context).accentColor,
            child: Text(
              DateFormat("hh:mm a").format(date),
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    color: AppTheme.light,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),*/
          Expanded(
            flex: 1,
            child: buildItemInfo(transaction, context),
          ),
        ],
      ),
    );
  }

  Card buildItemInfo(Transaction transaction, BuildContext context) {
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
                onTap: () {},
                /*=> Get.to(DetallePedido(
                    e: e, indiceCategoriaPedido: indiceCategoriaPedido)),*/
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextSubtitle(
                          text: 'e.nombreUsuario ??\'Cliente',
                          // style: TextoTheme.subtitleStyle2,
                        ),
                        TextSubtitle(
                          text: '11',
                          // text: 'e.cantidadPedido.toString()',
                          //  style: TextoTheme.subtitleStyle2
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextDescription(
                          text: transaction.name.toString(),
                        ),
                        //text: 'e.direccionUsuario ?? \'Sin ubicación'),
                        const TextDescription(text: '5 min')
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextDescription(
                          text: transaction.name.toString(),
                        ),

                        // text: controladorDePedidos  .formatoFecha(e.fechaHoraPedido)),
                        const TextDescription(text: '300 m')
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
/*
    Card(
      color: Colors.transparent,
      clipBehavior: Clip.none,
      elevation: 0.0,
      child: Container(
        color: Colors.transparent,
        /*  decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: transaction.point.isNegative
                  ? [AppTheme.blueLight, AppTheme.blueBackground]
                  : [AppTheme.blueOpacity, AppTheme.blueDark]),
        ),*/
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                child: Text(
                  transaction.name!,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: AppTheme.blueDark),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
              child: Text(
                "Cantidad: 1",
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: AppTheme.light),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
              child: Text(
                "Total: " +
                    NumberFormat.simpleCurrency().format(transaction.point),
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: AppTheme.light),
              ),
            ),
          ],
        ),
      ),
    );*/
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
            decoration: BoxDecoration(
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
