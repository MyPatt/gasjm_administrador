import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/modules/detail/detail_controller.dart';
import 'package:gasjm/app/modules/detail/widgets/aceptados_page.dart';
import 'package:gasjm/app/modules/detail/widgets/appbar_actions.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/modules/detail/widgets/finalizados_page.dart';
import 'package:gasjm/app/modules/detail/widgets/search.dart';
 
import 'package:get/get.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';

import 'widgets/content.dart';
import 'widgets/footer.dart';
import 'widgets/detalle_pedido.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailController>(
        builder: (_) => _.house.id.isEqual(0)
            ? DefaultTabController(
                length: 2,
                child: Scaffold(
                    backgroundColor: AppTheme.background,

                    //
                    appBar: AppBar(
                      backgroundColor: AppTheme.blueBackground,
                      // actions: const [MenuAppBar()],
                      title: Text(_.house.name),
                      bottom: const TabBar(
                        indicatorColor: Colors.white,
                        tabs: [
                          Tab(text: 'Aceptados'),
                          Tab(
                            text: 'Finalizados',
                          ),
                        ],
                      ),
                    ),
                    body: TabBarView(
                      children: [
                        PedidosAceptadosPage(),
                        PedidosAFinalizadosPage()
                      ],
                    )))
            : Scaffold(
                backgroundColor: AppTheme.background,

                //
                appBar: AppBar(
                  backgroundColor: AppTheme.blueBackground,
                  // actions: const [MenuAppBar()],
                  title: Text(_.house.name),
                ),
                body: Stack(children: [
                  Positioned.fill(
                      child: CustomScrollView(
                    slivers: [
                      Search(),
                      SliverToBoxAdapter(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              //Cantidad de total de pedidos en espera
                              TextDescription(
                                text: 'Aceptados',
                                textAlign: TextAlign.end,
                              ),
                            ]),
                      ),
                    ],
                  ))
                ]),
              ));
  }
}
