class CategoriaModelo {
  final int id;
  final String name;
  final String path;

  CategoriaModelo({required this.id, required this.name, required this.path});
}

final categoriasModulos = [
  CategoriaModelo(
    id: 0,
    name: 'Pedidos',
    path: 'assets/icons/gas.svg',
  ),
  CategoriaModelo(
    id: 1,
    name: 'Clientes',
    path: 'assets/icons/cliente.svg',
  ),
  CategoriaModelo(
    id: 2,
    name: 'Repartidores',
    path: 'assets/icons/repartidor.svg',
  ),
  CategoriaModelo(
    id: 3,
    name: 'Vehículos',
    path: 'assets/icons/vehiculo.svg',
  ),
];

final categoriasFechas = [
  CategoriaModelo(
    id: 0,
    name: 'Día',
    path: ' del ',
  ),
  CategoriaModelo(
    id: 1,
    name: 'Semana',
    path: ' de la ',
  ),
  CategoriaModelo(
    id: 2,
    name: 'Mes',
    path: ' del ',
  ),
  CategoriaModelo(
    id: 3,
    name: 'Calendario',
    path: ' de ',
  ),
];

//Lista de los estados (categorias) del pedido
//path=id del estado
final categoriasPedidos = [
  CategoriaModelo(
    id: 0,
    name: 'En espera',
    path: 'estado1',
  ),
  CategoriaModelo(
    id: 1,
    name: 'Aceptados',
    path: 'estado2',
  ),
  CategoriaModelo(
    id: 2,
    name: 'Finalizados',
    path: 'estado3',
  ),
  CategoriaModelo(
    id: 3,
    name: 'Cancelados',
    path: 'estado4',
  ),
];





