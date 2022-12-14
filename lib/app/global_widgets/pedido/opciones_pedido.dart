import 'package:flutter/material.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/global_widgets/pedido/aceptados_page.dart';
import 'package:gasjm/app/global_widgets/pedido/enespera_page.dart';
import 'package:gasjm/app/global_widgets/pedido/finalizados_page.dart';
import 'package:gasjm/app/global_widgets/pedido/rechazados_page.dart';

class OpcionesPedido extends StatelessWidget {
  const OpcionesPedido(
      {Key? key, required this.e, required this.indiceCategoriaPedido, required this.modo})
      : super(key: key);
  final PedidoModel e;
  final int indiceCategoriaPedido;
  final int modo;
  @override
  Widget build(BuildContext context) {
    return indiceCategoriaPedido == 0
        ? PedidosEnEsperaPage(idPedido: e.idPedido, modo: modo,idCliente: e.idCliente,)
        : indiceCategoriaPedido == 1
            ? PedidosAceptadosPage(
                idPedido: e.idPedido, modo: modo, idCliente: e.idCliente,
              )
            : indiceCategoriaPedido == 2
                ? PedidosAFinalizadosPage(idPedido: e.idPedido,)
                : PedidosRechazadosPage(idPedido: e.idPedido,);
  }
}
