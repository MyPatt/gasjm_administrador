import 'package:equatable/equatable.dart';

class ProductoModel extends Equatable {
  final String? idProducto;
  final String nombreProducto;
  final double precioProducto;
  final String? descripcionProducto;
  
  const ProductoModel({
    this.idProducto,
    required this.nombreProducto,
    required this.precioProducto,
      this.descripcionProducto,
  });

  factory ProductoModel.fromMap(Map<String, dynamic> json) => ProductoModel(
        idProducto: json["idProducto"],
        nombreProducto: json["nombreProducto"],
        precioProducto: json["precioProducto"],
        descripcionProducto: json["descripcionProducto"],
      );

  Map<String, dynamic> toMap() => {
        "idProducto": idProducto,
        "nombreProducto": nombreProducto,
        "precioProducto": precioProducto,
        "descripcionProducto": descripcionProducto,
      };

  @override
  List<Object?> get props =>
      [idProducto, nombreProducto, precioProducto, descripcionProducto];
}
