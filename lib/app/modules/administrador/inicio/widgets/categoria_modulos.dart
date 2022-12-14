import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/data/models/categoria_model.dart';
import 'package:gasjm/app/modules/administrador/inicio/inicio_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CategoriaModulos extends StatelessWidget {
  const CategoriaModulos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InicioAdministradorController>(
      builder: (_) => SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.only(top: 15.0),
          height: 130,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: categoriasModulos.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    _.seleccionarIndiceDeCategoria(index);
                  },
                  child: Obx(
                    () => ItemCategoriaModulos(
                      categoria: categoriasModulos[index],
                      indice: index,
                      cantidad: _.listaCantidadesModulos[index],
                    ),
                  ));
            },
          ),
        ),
      ),
    );
  }
}

class ItemCategoriaModulos extends StatelessWidget {
  const ItemCategoriaModulos({
    Key? key,
    required this.categoria,
    required this.indice,
    required this.cantidad,
  }) : super(key: key);

  final CategoriaModelo categoria;
  final int indice;
  final int cantidad;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<InicioAdministradorController>(
      builder: (_) => Obx(
        () {
          bool isSelected =
              indice == _.indiceModuloSeleccionado.value ? true : false;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            width: Responsive.getScreenSize(context).width * .28,
            margin: EdgeInsets.only(
              left: isSelected ? 20.0 : 11.0,
              bottom: isSelected ? 0 : 20.0,
            ),
            decoration: BoxDecoration(
              color: indice == _.indiceModuloSeleccionado.value
                  ? Colors.white
                  : Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  categoria.path,
                  width: 30.0,
                  color: isSelected
                      // ? Colors.white
                      ? AppTheme.blueDark
                      : AppTheme.light.withOpacity(.5),
                ),
                //

                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      right: 5.0,
                      left: 5.0,
                    ),
                    child: Text(
                      cantidad.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.caption?.copyWith(
                          color: AppTheme.light,
                          // isSelected ? AppTheme.blueDark : AppTheme.light,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      right: 5.0,
                      left: 5.0,
                    ),
                    child: Text(
                      categoria.name,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.caption?.copyWith(
                          color:
                              isSelected ? AppTheme.blueDark : AppTheme.light,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
