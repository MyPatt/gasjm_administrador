
class GasJm {
  GasJm({
    this.direccionGasJm,
    this.whatsappGasJm,
  });

  final String? direccionGasJm;
  final String? whatsappGasJm;

  factory GasJm.fromMap(Map<String, dynamic> json) => GasJm(
        direccionGasJm: json["direccionGasJM"],
        whatsappGasJm: json["whatsappGasJM"],
      );

  Map<String, dynamic> toMap() => {
        "direccionGasJM": direccionGasJm,
        "whatsappGasJM": whatsappGasJm,
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