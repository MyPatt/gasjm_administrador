import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/data/models/category_model.dart';
import 'package:gasjm/app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Category extends StatelessWidget {
  const Category({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) => SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.only(top: 15.0),
          height: 90,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  _.selectedIndex(index);
                },
                child: ItemCategory(
                  category: categories[index],
                  index: index,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ItemCategory extends StatelessWidget {
  ItemCategory({
    required this.category,
    required this.index,
  });

  final CategoryModel category;
  final int index;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) => Obx(
        () {
          bool isSelected = index == _.isSelectedIndex.value ? true : false;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            width: Responsive.getScreenSize(context).width * .28,
            margin: EdgeInsets.only(
              left: isSelected ? 20.0 : 11.0,
              bottom: isSelected ? 0 : 20.0,
            ),
            decoration: BoxDecoration(
              /* border: Border.all(
                color: index == _.isSelectedIndex.value
                    ? AppTheme.light
       
                    : Colors.white,
              ),*/
              color: index == _.isSelectedIndex.value
                  ? Colors.white
                  : Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  category.path,
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
                      category.name,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.caption?.copyWith(
                          color:
                              isSelected ? AppTheme.blueDark : AppTheme.light,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                /* isSelected
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 10.0,
                            right: 5.0,
                            left: 5.0,
                          ),
                          child: Text(
                            category.nombrePerfil,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(
                                    color: AppTheme.blueBackground,
                                    fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    : SizedBox()
                    */
              ],
            ),
          );
        },
      ),
    );
  }
}