import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/data/models/category_model.dart';
import 'package:gasjm/app/global_widgets/content_title.dart';
import 'package:gasjm/app/modules/home/home_controller.dart';
import 'package:gasjm/app/modules/home/widgets/bottom_administrador.dart';
import 'package:gasjm/app/modules/home/widgets/categoria_fechas.dart';
import 'package:gasjm/app/modules/home/widgets/categoria_modulos.dart';
import 'package:gasjm/app/global_widgets/menu_appbar.dart';
import 'package:gasjm/app/global_widgets/menu_lateral.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/modules/home/widgets/chart_pedidos.dart';
import 'package:gasjm/app/modules/home/widgets/contenido_pedidos.dart';
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
          body: CustomScrollView(
            slivers: [
              //Modulos de gestion por el administrador
              const CategoriaModulos(),
              //Primer subtitulo se adapta a la seleccion del modulo
              Obx(() => Subtitulo(
                    title: _.indiceDeFechaSeleccionada.value.isEqual(3)
                        ? categoriasModulos[_.indiceModuloSeleccionado.value]
                                .name +
                            categoriasFechas[_.indiceDeFechaSeleccionada.value]
                                .path +
                            _.fechaSeleccionadaString.value
                        : categoriasModulos[_.indiceModuloSeleccionado.value]
                                .name +
                            categoriasFechas[_.indiceDeFechaSeleccionada.value]
                                .path +
                            categoriasFechas[_.indiceDeFechaSeleccionada.value]
                                .name
                                .toLowerCase(),
                    more: "Ver todo",
                    onTap: () => _.navegarDashboard(),
                  )),

              //Modulo Pedidos
              const ContenidoPedidos()
            ],
          ),
          bottomNavigationBar: const BottomNavigationAdministrador()),
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
