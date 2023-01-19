import 'pedido_model.dart';

class GasJm {
  GasJm({
    this.direccionGasJm,
    this.whatsappGasJm,
    this.nombreLugar,
  });
  final Direccion? direccionGasJm;

  final String? whatsappGasJm;
  final String? nombreLugar;

  factory GasJm.fromMap(Map<String, dynamic> json) => GasJm(
        direccionGasJm: Direccion.fromMap(json["direccionGasJm"]),
        whatsappGasJm: json["whatsappGasJm"],
        nombreLugar: json["nombreLugar"],
      );

  Map<String, dynamic> toMap() => {
        "direccionGasJm": direccionGasJm?.toMap(),
        "whatsappGasJm": whatsappGasJm,
        "nombreLugar": nombreLugar
      };
}
  /*
  //GasJM({required this.direccion});
  // Metodos get
  //
  String? get getDireccion => direccionGasJm;
  String? get getWhatsap => whatsappGasJm;

  // Metodos set
  //
  set setDireccion(String nombre) => direccionGasJm = nombre;
  set setWhatsap(String numero) => whatsappGasJm = numero;

}
*/