 
import 'package:flutter/material.dart'; 
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/modules/home/home_controller.dart';
import 'package:gasjm/app/modules/home/widgets/categoria_fechas.dart';
import 'package:gasjm/app/modules/home/widgets/chart_pedidos.dart';
import 'package:get/get.dart';

class ContenidoPedidos extends StatelessWidget {
  const ContenidoPedidos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) => SliverToBoxAdapter(
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          //  padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.only(bottom: 15.0, left: 20.0, right: 20.0),
          height: Responsive.getScreenSize(context).height * .67,
          //
          child: ListView(
            children: [
              const CategoriaFechas(),
              const SizedBox(
                height: 25,
              ),
              Obx(() => ChartPedido(
                    puntos: _.pedidoPuntos.value,
                    indice: _.indiceDeFechaSeleccionada.value,
                  )),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
      ////
    );
  }
}
