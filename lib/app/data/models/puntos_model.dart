class PedidoPuntos {
  final double x;
  final double y;

  PedidoPuntos({required this.x, required this.y});
}

List<PedidoPuntos> get pedidoPuntos {
  final dataY = [4];
  final dataX = [
    "Hoy",
  ];
  return dataY.map((e) {
    var i = dataY.indexOf(e);
    i++;
    return PedidoPuntos(x: i.toDouble(), y: e.toDouble());
  }).toList();
}
