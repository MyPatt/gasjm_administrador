import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gasjm/app/data/models/estadopedido_model.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      {required String idPedido,
      required String estadoPedido,
      required String numeroEstadoPedido}) async {
    await _firestoreInstance.collection('pedido').doc(idPedido).update({
      "idEstadoPedido": estadoPedido,
      "idRepartidor": usuario!.uid,
      numeroEstadoPedido: EstadoPedido(
              idEstado: estadoPedido,
              fechaHoraEstado: Timestamp.now(),
              idPersona: usuario!.uid)
          .toMap()
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

//
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
        .orderBy("fechaHoraPedido")
        .get();
    if ((resultado.docs.isNotEmpty)) {
      return (resultado.docs)
          .map((item) => PedidoModel.fromJson(item.data()))
          .toList();
    }
    return null;
  }

  Future<List<PedidoModel>?> getPedidosPorField(
      {required String field, required String dato}) async {
    final resultado = await _firestoreInstance
        .collection("pedido")
        .where(field, isEqualTo: dato)
        .orderBy("fechaHoraPedido")
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
    final resultado = await _firestoreInstance.collection('pedido').get();
    return (resultado.docs)
        .map((item) => PedidoModel.fromJson(item.data()))
        .toList();
  }

  //
  
  //Obtener los cambios de los estados
  Future<EstadoDelPedido?> getEstadoPedidoPorField({
    required String uid,
    required String field,
  }) async {
    final resultado =
        await _firestoreInstance.collection("pedido").doc(uid).get();
    var datos = (resultado.get(field));

    if ((datos != null)) {
      return EstadoDelPedido.fromJson(resultado.get(field));
    } else {
      return null;
    }
  }

  //
  Future<String?> getNombreEstadoPedidoPorId({required String idEstado}) async {
    final snapshot = await _firestoreInstance
        .collection('estadopedido')
        .where("idEstadoPedido", isEqualTo: idEstado)
        .limit(1)
        .get();
    return snapshot.docs.first.get("nombreEstadoPedido").toString();
  }
//
    Future<List<PedidoModel>?> getListaPedidosPorField(
      {required String field, required String dato}) async {
    final resultado = await _firestoreInstance
        .collection("pedido")
        .where(field, isEqualTo: dato)
        .orderBy("fechaHoraPedido", descending: true)
        .get();
    if ((resultado.docs.isNotEmpty)) {
      return (resultado.docs)
          .map((item) => PedidoModel.fromJson(item.data()))
          .toList();
    }
    return null;
  }
}
