import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/data/models/category_model.dart';
import 'package:gasjm/app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriaFechas extends StatelessWidget {
  const CategoriaFechas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) => Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(
          bottom: 15.00,
        ),
        height: 35.0,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: categoriasFechas.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                _.seleccionarIndiceDeFecha(index);
                if (index.isEqual(3)) {
                  _.seleccionarFechaDelCalendario(context);
                }
              },
              child: ItemCategoriaFechas(
                categoria: categoriasFechas[index],
                indice: index,
              ),
            );
          },
        ),
      ),
    );
  }
}

class ItemCategoriaFechas extends StatelessWidget {
  const ItemCategoriaFechas({
    Key? key,
    required this.categoria,
    required this.indice,
  }) : super(key: key);

  final CategoriaModelo categoria;
  final int indice;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) => Obx(
        () {
          bool isSelected =
              indice == _.indiceDeFechaSeleccionada.value ? true : false;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 65.0,
            margin: EdgeInsets.only(
              left: isSelected ? 20.0 : 11.0,
              bottom: isSelected ? 0 : 20.0,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: indice == _.indiceDeFechaSeleccionada.value
                    ? AppTheme.light
                    : Colors.white,
              ),
              color: Colors.white,
              borderRadius: BorderRadius.circular(13.0),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  // top: 10.0,
                  right: 3.0,
                  left: 3.0,
                ),
                child: categoria.id.isEqual(3)
                    ? Icon(
                        Icons.calendar_month_sharp,
                        color: isSelected
                            // ? Colors.white
                            ? AppTheme.blueDark
                            : AppTheme.light.withOpacity(.5),
                      )
                    : Text(
                        categoria.name,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption?.copyWith(
                            color: isSelected
                                // ? Colors.white
                                ? AppTheme.blueDark
                                : AppTheme.light.withOpacity(.5),
                            fontWeight: FontWeight.bold),
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
