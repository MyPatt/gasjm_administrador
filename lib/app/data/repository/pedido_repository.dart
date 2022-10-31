import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';

abstract class PedidoRepository {
  Future<void> insertPedido({required PedidoModel pedidoModel});
  Future<void> updateEstadoPedido(
      {required String idPedido, required String estadoPedido});
  Future<void> deletePedido({required String pedido});
  Future<List<PedidoModel>> getPedidosEnEsperaYAceptados();
  Future<List<PedidoModel>?> getPedidosPorDosQueries({
    required String field1,
    required String dato1,
    required String field2,
    required String dato2,
  });
  Future<List<PedidoModel>?> getPedidoPorField(
      {required String field, required String dato});
  Future<int> getCantidadPedidosPorHora({required Timestamp fechaHora});
  Future<int> getCantidadPedidosPorPorDias({required Timestamp fechaDia});
}
