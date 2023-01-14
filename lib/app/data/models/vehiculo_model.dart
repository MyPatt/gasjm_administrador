class Vehiculo {
  Vehiculo({
    this.idVehiculo,
    required this.idRepartidor,
    required this.placaVehiculo,
    required this.marcaVehiculo,
    required this.modeloVehiculo,
    required this.anioVehiculo,
    this.colorVehiculo,
    this.tipoVehiculo,
    this.fotoVehiculo,
    this.observacionVehiculo,
  });

  final String? idVehiculo;
  final String idRepartidor;
  final String placaVehiculo;
  final String marcaVehiculo;
  final String modeloVehiculo;
  final int anioVehiculo;
  final String? colorVehiculo;
  final String? tipoVehiculo;
  final String? fotoVehiculo;
  final String? observacionVehiculo;
  String? nombresRepartidor;

  factory Vehiculo.fromMap(Map<String, dynamic> json) => Vehiculo(
        idVehiculo: json["idVehiculo"],
        idRepartidor: json["idRepartidor"],
        placaVehiculo: json["placaVehiculo"],
        marcaVehiculo: json["marcaVehiculo"],
        modeloVehiculo: json["modeloVehiculo"],
        anioVehiculo: json["anioVehiculo"], 
        fotoVehiculo: json["fotoVehiculo"],
        observacionVehiculo: json["observacionVehiculo"],
      );

  Map<String, dynamic> toMap() => {
        "idVehiculo": idVehiculo,
        "idRepartidor": idRepartidor,
        "placaVehiculo": placaVehiculo,
        "marcaVehiculo": marcaVehiculo,
        "modeloVehiculo": modeloVehiculo,
        "anioVehiculo": anioVehiculo,
        "fotoVehiculo":fotoVehiculo,
        "observacionVehiculo": observacionVehiculo
      };
}
