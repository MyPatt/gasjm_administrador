import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/modules/administrador/inicio/inicio_controller.dart';
import 'package:gasjm/app/modules/administrador/inicio/widgets/categoria_fechas.dart';
import 'package:gasjm/app/modules/administrador/inicio/widgets/chart_pedidos.dart';
import 'package:get/get.dart';

class ContenidoPedidos extends StatelessWidget {
  const ContenidoPedidos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InicioAdministradorController>(
      builder: (_) => SliverToBoxAdapter(
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          //  padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.only(bottom: 15.0, left: 20.0, right: 20.0),
          height: Responsive.getScreenSize(context).height * .54,
          //
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              const CategoriaFechas(),
              Obx(() => TextDescription(text: " ${_.totalCantidad.value}")),
              const SizedBox(
                height: 10,
              ),
              Obx(() {
                final estadoProceso = _.cargandoParaDia.value;
                return Stack(alignment: Alignment.center, children: [
                  ChartPedido(
                    // ignore: invalid_use_of_protected_member
                    puntos: _.pedidoPuntos.value,
                    indice: _.indiceDeFechaSeleccionada.value,
                  ),
                  if (estadoProceso)
                    const CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      color: AppTheme.blueBackground,
                    ),
                ]);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
