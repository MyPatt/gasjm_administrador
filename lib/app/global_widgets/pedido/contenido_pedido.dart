// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/data/controllers/pedido_controller.dart';
import 'package:gasjm/app/global_widgets/pedido/detalle_pedido.dart';
import 'package:gasjm/app/global_widgets/pedido/opciones_pedido.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
import 'package:get/get.dart';

class ContenidoPedido extends StatelessWidget {
  ContenidoPedido(
      {Key? key, required this.indiceCategoriaPedido, required this.modo})
      : super(key: key);
  final PedidoController controladorDePedidos = Get.put(PedidoController());
  final int indiceCategoriaPedido;
  final int modo;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => RefreshIndicator(
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
                    child: ListView(
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
                                              indiceCategoriaPedido,
                                          modo: modo,
                                        )),
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
                                  indiceCategoriaPedido: indiceCategoriaPedido,
                                  modo: modo,
                                )
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pullRefrescar() async {
    //controladorDePedidos.listaPedidosXCategoria("estado1").value;
    // 0 administrador
    //1 repartidor
    if (modo == 0) {
      controladorDePedidos
          .cargarListaPedidosParaAdministrador(indiceCategoriaPedido);
    }
    if (modo == 1) {
      controladorDePedidos
          .cargarListaPedidosParaRepartidor(indiceCategoriaPedido);
    }

    await Future.delayed(const Duration(seconds: 2));
  }
}
