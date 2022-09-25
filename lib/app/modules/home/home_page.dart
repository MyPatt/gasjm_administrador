import 'package:fl_chart/fl_chart.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/data/models/category_model.dart';
import 'package:gasjm/app/global_widgets/content_title.dart';
import 'package:gasjm/app/modules/home/home_controller.dart';
import 'package:gasjm/app/modules/home/widgets/category%20copy.dart';
import 'package:gasjm/app/modules/home/widgets/category.dart';
import 'package:gasjm/app/global_widgets/repartidor/menu_appbar.dart';
import 'package:gasjm/app/global_widgets/menu_lateral.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) => Scaffold(
        backgroundColor: AppTheme.background,
        //Menú deslizable a la izquierda con opciones del  usuario
        drawer: const MenuLateral(),
        //Barra de herramientas de opciones
        appBar: AppBar(
          backgroundColor: AppTheme.blueBackground,
          actions: const [MenuAppBar()],
          title: const Text('GasJ&M'),
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: CustomScrollView(
                slivers: [
                  // Header(),
                  // Search(),*/
                  const Category(),
                  Obx(() => ContentTitle(
                        //   title: "Nearby to you",
                        title: _.isSelectedIndexFecha.value.isEqual(3)
                            ? categories[_.isSelectedIndex.value].name +
                                categoriesDates[_.isSelectedIndexFecha.value]
                                    .path +
                                _.selectedDate.value
                            : categories[_.isSelectedIndex.value].name +
                                categoriesDates[_.isSelectedIndexFecha.value]
                                    .path +
                                categoriesDates[_.isSelectedIndexFecha.value]
                                    .name
                                    .toLowerCase(),
                        more: "Ver todo",
                        onTap: ()=>_.navegarDashboard(),
                      /*  onTap: () => Get.toNamed(AppRoutes.detail,
                            arguments: categories[_.isSelectedIndex.value]),*/
                      )),

                  //   Houses(),
                  SliverToBoxAdapter(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      //  padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.only(
                          bottom: 15.0, left: 20.0, right: 20.0),
                      height: Responsive.getScreenSize(context).height * .67,
                      //
                      child: ListView(
                        children: [
                          const CategoryCopy(),
                          const SizedBox(
                            height: 25,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height:
                                Responsive.getScreenSize(context).height * .54,
                            child: LineChart(
                              LineChartData(
                                  borderData: FlBorderData(show: false),
                                  lineBarsData: [
                                    LineChartBarData(colors: [
                                      AppTheme.blueBackground
                                    ], spots: [
                                      const FlSpot(0, 1),
                                      const FlSpot(1, 3),
                                      const FlSpot(2, 10),
                                      const FlSpot(3, 7),
                                      const FlSpot(4, 12),
                                      const FlSpot(5, 13),
                                      const FlSpot(6, 17),
                                      const FlSpot(7, 15),
                                      const FlSpot(8, 20)
                                    ])
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
