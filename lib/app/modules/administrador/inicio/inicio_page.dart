import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/data/models/categoria_model.dart';
import 'package:gasjm/app/global_widgets/content_title.dart';
import 'package:gasjm/app/global_widgets/bottom_administrador.dart';
import 'package:gasjm/app/modules/administrador/inicio/inicio_controller.dart';

import 'package:gasjm/app/modules/administrador/inicio/widgets/contenido_pedidos.dart';

import 'package:gasjm/app/modules/administrador/inicio/widgets/categoria_modulos.dart'; 
import 'package:gasjm/app/global_widgets/menu_lateral.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InicioAdministradorPage extends StatelessWidget {
  const InicioAdministradorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InicioAdministradorController>(
      builder: (_) => Scaffold(
          backgroundColor: AppTheme.background,
          //Menú deslizable a la izquierda con opciones del  usuario
          drawer: MenuLateral(
            modo: 'Modo repartidor',
            imagenPerfil: _.imagenUsuario,
          ),
          //Barra de herramientas de opciones
          appBar: AppBar(
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
            ),
            backgroundColor: AppTheme.blueBackground, 
            title: const Text('GasJ&M'),
          ),
          body: Obx(
            () => AbsorbPointer(
              absorbing: _.cargandoParaDia.value,
              child: CustomScrollView(
                slivers: [
                  //Modulos de gestion por el administrador
                  const CategoriaModulos(),
                  //Primer subtitulo se adapta a la seleccion del modulo
                  Obx(() => Subtitulo(
                        title: _.indiceDeFechaSeleccionada.value.isEqual(3)
                            ? categoriasModulos[
                                        _.indiceModuloSeleccionado.value]
                                    .name +
                                categoriasFechas[
                                        _.indiceDeFechaSeleccionada.value]
                                    .path +
                                _.fechaSeleccionadaString.value
                            : categoriasModulos[
                                        _.indiceModuloSeleccionado.value]
                                    .name +
                                categoriasFechas[
                                        _.indiceDeFechaSeleccionada.value]
                                    .path +
                                categoriasFechas[
                                        _.indiceDeFechaSeleccionada.value]
                                    .name
                                    .toLowerCase(),
                        more: "Ver todo",
                        onTap: () => _.navegarDashboard(),
                      )),

                  //Modulo Pedidos
                  const ContenidoPedidos()
                ],
              ),
            ),
          ),
          bottomNavigationBar:
              const BottomNavigationAdministrador(indiceActual: 0)),
    );
  }
}
