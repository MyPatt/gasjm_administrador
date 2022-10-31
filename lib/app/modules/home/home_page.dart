 
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/data/models/category_model.dart'; 
import 'package:gasjm/app/global_widgets/content_title.dart';
import 'package:gasjm/app/modules/home/home_controller.dart';
import 'package:gasjm/app/modules/home/widgets/categoria_fechas.dart';
import 'package:gasjm/app/modules/home/widgets/categoria_modulos.dart';
import 'package:gasjm/app/global_widgets/menu_appbar.dart';
import 'package:gasjm/app/global_widgets/menu_lateral.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/modules/home/widgets/chart_pedidos.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) => Scaffold(
        backgroundColor: AppTheme.background,
        //Menú deslizable a la izquierda con opciones del  usuario
        drawer: MenuLateral(
          modo: 'Modo repartidor',
          foto: Obx(() => buildImage(_.imagenUsuario.value)),
        ),
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
                        title: _.indiceDeFechaSeleccionada.value.isEqual(3)
                            ? categories[_.isSelectedIndex.value].name +
                                categoriesDates[
                                        _.indiceDeFechaSeleccionada.value]
                                    .path +
                                _.selectedDate.value
                            : categories[_.isSelectedIndex.value].name +
                                categoriesDates[
                                        _.indiceDeFechaSeleccionada.value]
                                    .path +
                                categoriesDates[
                                        _.indiceDeFechaSeleccionada.value]
                                    .name
                                    .toLowerCase(),
                        more: "Ver todo",
                        onTap: () => _.navegarDashboard(),
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
                          Obx(() => ChartPedido(puntos: _.pedidoPuntos.value, indice: _.indiceDeFechaSeleccionada.value,)),
                          const SizedBox(
                            height: 25,
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

  Widget buildImage(String? imagenPerfil) {
    return imagenPerfil == null
        ? const CircleAvatar(
            backgroundColor: AppTheme.light,
            radius: 38.0,
            child: CircleAvatar(
                backgroundColor: AppTheme.light,
                radius: 35.0,
                backgroundImage: AssetImage(
                  'assets/icons/placehoderperfil.png',
                )),
          )
        : CircleAvatar(
            backgroundColor: AppTheme.light,
            radius: 38.0,
            backgroundImage: NetworkImage(imagenPerfil));
  }
}
