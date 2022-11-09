import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';import 'package:firebase_auth/firebase_auth.dart';

class PedidoProvider {
  //Instancia de firestore
  final _firestoreInstance = FirebaseFirestore.instance;
 final usuario = FirebaseAuth.instance.currentUser;
  //
  Future<void> insertPedido({required PedidoModel pedidoModel}) async {
    final resultado =
        await _firestoreInstance.collection('pedido').add(pedidoModel.toJson());

    await _firestoreInstance
        .collection("pedido")
        .doc(resultado.id)
        .update({"idPedido": resultado.id});
  }
  //

  Future<void> updateEstadoPedido(
      {required String idPedido, required String estadoPedido,required String numeroEstadoPedido }) async {
    await _firestoreInstance
        .collection('pedido')
        .doc(idPedido)
        .update({"idEstadoPedido": estadoPedido,
        
        numeroEstadoPedido:EstadoPedido(idEstado: estadoPedido  , fechaHoraEstado: Timestamp.now(), idPersona: usuario!.uid).toMap()
 });
  }

  //
  Future<void> deletePedido({required String pedido}) async {
    await _firestoreInstance.collection('pedido').doc(pedido).delete();
  }

  //
  Future<List<PedidoModel>> getPedidosEnEsperaYAceptados() async {
    final resultado = await _firestoreInstance
        .collection('pedido')
        .where("idEstadoPedido", whereIn: ["estado1", "estado2"]).get();

    return (resultado.docs)
        .map((item) => PedidoModel.fromJson(item.data()))
        .toList();
  }

  Future<PedidoModel?> getPedidoPorUid({required String uid}) async {
    final resultado =
        await _firestoreInstance.collection('pedido').doc(uid).get();
    if ((resultado.exists)) {
      return PedidoModel.fromJson(resultado.data()!);
    }
    return null;
  }

  Future<List<PedidoModel>?> getPedidosPorDosQueries({
    required String field1,
    required String dato1,
    required String field2,
    required String dato2,
  }) async {
    final resultado = await _firestoreInstance
        .collection("pedido")
        .where(field1, isEqualTo: dato1)
        .where(field2, isEqualTo: dato2)
        .get();
    if ((resultado.docs.isNotEmpty)) {
      return (resultado.docs)
          .map((item) => PedidoModel.fromJson(item.data()))
          .toList();
    }
    return null;
  }

  Future<List<PedidoModel>?> getPedidoPorField(
      {required String field, required String dato}) async {
    final resultado = await _firestoreInstance
        .collection("pedido")
        .where(field, isEqualTo: dato)
        .get();
    if ((resultado.docs.isNotEmpty)) {
      return (resultado.docs)
          .map((item) => PedidoModel.fromJson(item.data()))
          .toList();
    }
    return null;
  }

  //Retornar la cantidad de pedidos por hora
  Future<int> getCantidadPedidosPorHora(
      {required Timestamp horaFechaInicial}) async {
    final resultado = await _firestoreInstance
        .collection("pedido")
        .where("fechaHoraPedido", isGreaterThanOrEqualTo: horaFechaInicial)
        .where("fechaHoraPedido",
            isLessThanOrEqualTo: Timestamp(horaFechaInicial.seconds + 3600, 0))
        .where("idEstadoPedido", isEqualTo: "estado3")
        .get();

    return resultado.docs.length;
  }

  //Retornar la cantidad de pedidos por hora
  Future<int> getCantidadPedidosPorDia(
      {required Timestamp fechaInicial}) async {
    /* var fecha = Timestamp.fromDate(DateTime(
      fechaInicial.year,
      fechaInicial.month,
      (fechaInicial.day),
    ));*/

    final resultado = await _firestoreInstance
        .collection("pedido")
        .where("fechaHoraPedido", isGreaterThanOrEqualTo: fechaInicial)
        .where("fechaHoraPedido",
            isLessThanOrEqualTo: Timestamp(fechaInicial.seconds + 86400, 0))
        .where("idEstadoPedido", isEqualTo: "estado3")
        .get();

    return resultado.docs.length;
  }

  //Retornar la cantidad de pedidos por hora
  Future<int> getCantidadPedidosPorfield(
    {required String field, required String dato}) async {
    final resultado = await _firestoreInstance
        .collection("pedido")
        .where(field, isEqualTo: dato)
        .get();
  
    return resultado.docs.length;
  }
    //
  Future<List<PedidoModel>> getPedidos() async {
    final resultado = await _firestoreInstance
        .collection('pedido').get(); 
    return (resultado.docs)
        .map((item) => PedidoModel.fromJson(item.data()))
        .toList();
  }
}
