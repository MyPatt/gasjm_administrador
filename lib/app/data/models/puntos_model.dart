class PedidoPuntos {
  final int x;
  final int y;

  PedidoPuntos({required this.x, required this.y});

  static const List<String> horasDelDia = [
    "06:00",
    "07:00",
    "08:00",
    "09:00",
    "10:00",
    "11:00",
    "12:00",
    "13:00",
    "14:00",
    "15:00",
    "16:00",
    "17:00",
    "18:00",
    "19:00" , 
    "19:00"
  ];
}

List<PedidoPuntos> get pedidoPuntos {
  final List<int> dataY = [2, 0, 0, 0, 5, 5, 0, 11, 7];
  final dat = [
    4, 7, 8,
    0,
    2,
    6,
    1,

    9, 1111,
    5,
    10,
    13,
    12,
    11,
    // 0, 0, 0, 0, 0, 0, 0, 0, 0
  ];
  List<PedidoPuntos> _puntosAux = [];
  for (var i = 0; i < dataY.length; i++) {
    _puntosAux.add(PedidoPuntos(x: i, y: dataY[i]));
    print("*");
    print(i);
  }
  return _puntosAux;
  /* return dataY.map((e) {
    var i = 0;
    i++;
    print("-");
    print(i);
    return PedidoPuntos(x: dataY.indexOf(e).toDouble(), y: e.toDouble());
  }).toList();*/
}
