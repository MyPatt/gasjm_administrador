class Vehiculo {
  Vehiculo({
    required this.idVehiculo,
    required this.idRepartidor,
    required this.placaVehiculo,
    required this.marcaVehiculo,
    required this.modeloVehiculo,
    required this.anioVehiculo,
    required this.colorVehiculo,
    required this.tipoVehiculo,
    required this.observacionVehiculo,
  });

  final String idVehiculo;
  final String idRepartidor;
  final String placaVehiculo;
  final String marcaVehiculo;
  final String modeloVehiculo;
  final int anioVehiculo;
  final String colorVehiculo;
  final String tipoVehiculo;
  final String observacionVehiculo;

  factory Vehiculo.fromMap(Map<String, dynamic> json) => Vehiculo(
        idVehiculo: json["idVehiculo"],
        idRepartidor: json["idRepartidor"],
        placaVehiculo: json["placaVehiculo"],
        marcaVehiculo: json["marcaVehiculo"],
        modeloVehiculo: json["modeloVehiculo"],
        anioVehiculo: json["anioVehiculo"],
        colorVehiculo: json["colorVehiculo"],
        tipoVehiculo: json["tipoVehiculo"],
        observacionVehiculo: json["observacionVehiculo"],
      );

  Map<String, dynamic> toMap() => {
        "idVehiculo": idVehiculo,
        "idRepartidor": idRepartidor,
        "placaVehiculo": placaVehiculo,
        "marcaVehiculo": marcaVehiculo,
        "modeloVehiculo": modeloVehiculo,
        "anioVehiculo": anioVehiculo,
      };
}
