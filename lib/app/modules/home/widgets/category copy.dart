import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/data/models/category_model.dart';
import 'package:gasjm/app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryCopy extends StatelessWidget {
  const CategoryCopy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) => Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(
          top: 15.00,
        ),
        //padding: const EdgeInsets.only(top: 15.0),
        height: 35.0,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: categoriesDates.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                _.seleccionarIndiceDeFecha(index);
                if (index.isEqual(3)) {
                  _.selectDate(context);
                }
              },
              child: ItemCategory(
                category: categoriesDates[index],
                index: index,
              ),
            );
          },
        ),
      ),
    );
  }
}

class ItemCategory extends StatelessWidget {
  const ItemCategory({
    Key? key,
    required this.category,
    required this.index,
  }) : super(key: key);

  final CategoryModel category;
  final int index;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) => Obx(
        () {
          bool isSelected =
              index == _.indiceDeFechaSeleccionada.value ? true : false;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 65.0,
            margin: EdgeInsets.only(
              left: isSelected ? 20.0 : 11.0,
              bottom: isSelected ? 0 : 20.0,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: index == _.indiceDeFechaSeleccionada.value
                    ? AppTheme.light
                    : Colors.white,
              ),
              color: Colors.white,
              /*color: index == _.isSelectedIndex.value
                  ? AppTheme.blueBackground
                  : Colors.white,*/
              borderRadius: BorderRadius.circular(13.0),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  // top: 10.0,
                  right: 3.0,
                  left: 3.0,
                ),
                child: category.id.isEqual(3)
                    ? Icon(
                        Icons.calendar_month_sharp,
                        color: isSelected
                            // ? Colors.white
                            ? AppTheme.blueDark
                            : AppTheme.light.withOpacity(.5),
                      )
                    /*  ? IconButton(
                        padding: const EdgeInsets.all(0.0),
                        alignment: Alignment.center,
                        icon: const Icon(Icons.calendar_month_sharp),
                        color: isSelected
                            // ? Colors.white
                            ? AppTheme.blueDark
                            : AppTheme.light.withOpacity(.5),
                        onPressed: () {
                          Future.wait([_.selectDate(context)]);
                        },
                      )*/
                    : Text(
                        category.name,
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
