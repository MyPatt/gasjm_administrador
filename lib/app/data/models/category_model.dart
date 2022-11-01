/*class CategoryModel {
  int id;
  String name;
  String path;

  CategoryModel(this.id, this.name, this.path);
}

final categories = [
  CategoryModel(
    0,
    'Pedidos',
    'assets/icons/botella-con-gas.svg',
  ),
  CategoryModel(
    1,
    'Clientes',
    'assets/icons/cliente.svg',
  ),
  CategoryModel(
    2,
    'Repartidores',
    'assets/icons/repartidor.svg',
  ),
];

final categoriesDates = [
  CategoryModel(
    0,
    'Día',
    ' del ',
  ),
  CategoryModel(
    1,
    'Semana',
    ' de la ',
  ),
  CategoryModel(
    2,
    'Mes',
    ' del ',
  ),
  CategoryModel(
    3,
    'Calendario',
    ' de ',
  ),
];
*/
class CategoryModel {
  final int id;
  final String name;
  final String path;

  CategoryModel({required this.id, required this.name, required this.path});
}

final categories = [
  CategoryModel(
    id: 0,
    name: 'Pedidos',
    path: 'assets/icons/botella-con-gas.svg',
  ),
  CategoryModel(
    id: 1,
    name: 'Clientes',
    path: 'assets/icons/cliente.svg',
  ),
  CategoryModel(
    id: 2,
    name: 'Repartidores',
    path: 'assets/icons/repartidor.svg',
  ), CategoryModel(
    id: 3,
    name: 'Vehículos',
    path: 'assets/icons/repartidor.svg',
  ),
];

final categoriesDates = [
  CategoryModel(
    id: 0,
    name: 'Día',
    path: ' del ',
  ),
  CategoryModel(
    id: 1,
    name: 'Semana',
    path: ' de la ',
  ),
  CategoryModel(
    id: 2,
    name: 'Mes',
    path: ' del ',
  ),
  CategoryModel(
    id: 3,
    name: 'Calendario',
    path: ' de ',
  ),
];
