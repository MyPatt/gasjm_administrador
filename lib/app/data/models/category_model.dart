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
class CategoriaModelo {
  final int id;
  final String name;
  final String path;

  CategoriaModelo({required this.id, required this.name, required this.path});
}

final categories = [
  CategoriaModelo(
    id: 0,
    name: 'Pedidos',
    path: 'assets/icons/botella-con-gas.svg',
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
    path: 'assets/icons/repartidor.svg',
  ),
];

final categoriesDates = [
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
