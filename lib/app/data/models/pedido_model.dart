import 'package:cloud_firestore/cloud_firestore.dart';

class PedidoModel {
  final String idPedido;
  final String idProducto;
  final String idCliente;
  final String idRepartidor;
  final Direccion direccion;
  final String idEstadoPedido;
  final Timestamp fechaHoraPedido;
  final String diaEntregaPedido;
  // final String? horaEntregaPedido;
  //final Timestamp? fechaHoraEntregaPedido;
  //Para guardar los datos cuando el pedido esta en espera (info de quien acepta o rechaza el pedido)
  final EstadoPedido? estadoPedido1;
  //Para guardar los datos cuando el pedido esta en camino (info de quien esta camino a entregar el pedido)

  final EstadoPedido? estadoPedido2;
  //Para guardar los datos cuando el pedido se a finalizado (info de quien cancela o finaliza el pedido)

  final EstadoPedido? estadoPedido3;

 


  final int cantidadPedido;
  final String? notaPedido;
  final double totalPedido;

  //
  String? nombreUsuario;
  String? direccionUsuario;
    String? estadoPedidoUsuario;
  int? tiempoEntrega;

  //
  PedidoModel(
      {required this.idPedido,
      required this.idProducto,
      required this.idCliente,
      required this.idRepartidor,
      required this.direccion,
      required this.idEstadoPedido,
      required this.fechaHoraPedido,
      required this.diaEntregaPedido,
      required this.cantidadPedido,
      required this.notaPedido,
      required this.totalPedido,
      this.estadoPedido1,
      this.estadoPedido2,
      this.estadoPedido3,
      this.nombreUsuario,
      this.direccionUsuario,
      this.tiempoEntrega});

  factory PedidoModel.fromJson(Map<String, dynamic> json) => PedidoModel(
        idPedido: json["idPedido"],
        idProducto: json["idProducto"],
        idCliente: json["idCliente"],
        idRepartidor: json["idRepartidor"],
        idEstadoPedido: json["idEstadoPedido"],
        fechaHoraPedido: json["fechaHoraPedido"],
        /*
        
        estadoPedido1: EstadoPedido.fromMap(json["estadoPedido1"]),
              estadoPedido2: EstadoPedido.fromMap(json["estadoPedido2"]),
        estadoPedido3: EstadoPedido.fromMap(json["estadoPedido3"]),
*/
        diaEntregaPedido: json["diaEntregaPedido"],
        notaPedido: json["notaPedido"],
        totalPedido: json["totalPedido"],
        direccion: Direccion.fromMap(json["direccion"]),
        cantidadPedido: json["cantidadPedido"],
      );

  Map<String, dynamic> toJson() => {
        "idPedido": idPedido,
        "idProducto": idProducto,
        "idCliente": idCliente,
        "idRepartidor": idRepartidor,
        "idEstadoPedido": idEstadoPedido,
        "fechaHoraPedido": fechaHoraPedido,
        "estadoPedido1": estadoPedido1,
        "estadoPedido2": estadoPedido2,
        "estadoPedido3": estadoPedido3,
        "diaEntregaPedido": diaEntregaPedido,
        "notaPedido": notaPedido,
        "totalPedido": totalPedido,
        "direccion": direccion.toMap(),
        "cantidadPedido": cantidadPedido,
      };
}

class Direccion {
  Direccion({
    required this.latitud,
    required this.longitud,
  });

  final double latitud;
  final double longitud;

  factory Direccion.fromMap(Map<String, dynamic> json) => Direccion(
        latitud: json["latitud"],
        longitud: json["longitud"],
      );

  Map<String, dynamic> toMap() => {
        "latitud": latitud,
        "longitud": longitud,
      };
}
//Clases con6 atributos del estado id, fechaHora, idPersona quien a cambiado el estado puede ser el cliente, repartidor o el admin
class EstadoPedido {
  EstadoPedido({
    required this.idEstado,
    required this.fechaHoraEstado,
    required this.idPersona,
  });

  final String idEstado;
  final Timestamp fechaHoraEstado;
  final String idPersona;

  factory EstadoPedido.fromMap(Map<String, dynamic> json) => EstadoPedido(
      idEstado: json["idEstado"],
      fechaHoraEstado: json["fechaHoraEstado"],
      idPersona: json["idPersona"]);
  Map<String, dynamic> toMap() => {
        "idEstado": idEstado,
        "fechaHoraEstado": fechaHoraEstado,
        "idPersona": idPersona
      };
}
