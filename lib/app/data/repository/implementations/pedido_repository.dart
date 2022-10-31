import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/data/providers/pedido_provider.dart';
import 'package:gasjm/app/data/repository/pedido_repository.dart';
import 'package:get/get.dart';

class PedidoRepositoryImpl extends PedidoRepository {
  final _provider = Get.find<PedidoProvider>();

  @override
  Future<List<PedidoModel>> getPedidosEnEsperaYAceptados() =>
      _provider.getPedidosEnEsperaYAceptados();

  @override
  Future<void> insertPedido({required PedidoModel pedidoModel}) =>
      _provider.insertPedido(pedidoModel: pedidoModel);

  @override
  Future<void> deletePedido({required String pedido}) =>
      _provider.deletePedido(pedido: pedido);

  @override
  Future<List<PedidoModel>?> getPedidosPorDosQueries({
    required String field1,
    required String dato1,
    required String field2,
    required String dato2,
  }) =>
      _provider.getPedidosPorDosQueries(
          field1: field1, dato1: dato1, field2: field2, dato2: dato2);

  @override
  Future<void> updateEstadoPedido(
          {required String idPedido, required String estadoPedido}) =>
      _provider.updateEstadoPedido(
          idPedido: idPedido, estadoPedido: estadoPedido);

  @override
  Future<List<PedidoModel>?> getPedidoPorField(
          {required String field, required String dato}) =>
      _provider.getPedidoPorField(field: field, dato: dato);
  @override
  Future<int> getCantidadPedidosPorHora({required Timestamp fechaHora}) =>
      _provider.getCantidadPedidosPorHora(horaFechaInicial: fechaHora);

  @override
  Future<int> getCantidadPedidosPorPorDias({required Timestamp fechaDia}) =>
      _provider.getCantidadPedidosPorDia(fechaInicial: fechaDia);
}
