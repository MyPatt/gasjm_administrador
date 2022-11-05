import 'package:flutter/material.dart';
import 'package:gasjm/app/data/models/categoria_model.dart'; 

//Barra de herramientas de opciones para la agenda y el historial
class MenuAppBar extends StatelessWidget {
  const MenuAppBar({key, required this.indiceMenu}) : super(key: key);
  final int indiceMenu;
  @override
  Widget build(BuildContext context) {
    return indiceMenu == categoriasModulos[0].id
        ? _builOpcionesInicio(context)
        : _builOpcionesPedidos(context);
  }
}

Widget _builOpcionesInicio(BuildContext context) {
  return Row(
    children: [
      IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none_outlined)),
      const SizedBox(
        width: 10,
      ),
    ],
  );
}

Widget _builOpcionesPedidos(BuildContext context) {
  return Row(
    children: [
      IconButton(onPressed: () {}, icon: const Icon(Icons.search_outlined)), 
      IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list_outlined)),
      const SizedBox(
        width: 10,
      ),
    ],
  );
}
