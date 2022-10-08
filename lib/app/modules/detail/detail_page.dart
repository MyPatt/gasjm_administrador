 
import 'package:gasjm/app/modules/detail/detail_controller.dart';
import 'package:gasjm/app/modules/detail/widgets/aceptados_page.dart'; 
import 'package:flutter/material.dart';
import 'package:gasjm/app/modules/detail/widgets/finalizados_page.dart'; 
 
import 'package:get/get.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailController>(
        builder: (_) => 
        DefaultTabController(
                length: 2,
                child: Scaffold(
                    backgroundColor: AppTheme.background,

                    //
                    appBar: AppBar(
                      backgroundColor: AppTheme.blueBackground,
                      // actions: const [MenuAppBar()],
                      title: const Text("Pedidos"),
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
                    )
                    )
                    )
            );
  }

  
}
