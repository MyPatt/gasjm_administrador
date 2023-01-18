import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/modules/gasjm/widgets/contenido_horario.dart';
import 'package:gasjm/app/modules/gasjm/widgets/contenido_informacion.dart';
import 'package:gasjm/app/modules/gasjm/widgets/contenido_ruta.dart';

class GasJMPage extends StatelessWidget {
  const GasJMPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,

      //
      appBar: AppBar(
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        backgroundColor: AppTheme.blueBackground,
        automaticallyImplyLeading: true,
        title: const Text("Gas J&M"),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: const TabBar(
                indicatorColor: AppTheme.blueBackground,
                labelColor: AppTheme.blueBackground,
                unselectedLabelColor: AppTheme.light,
                tabs: [
                  Tab(text: 'Información'),
                  Tab(text: 'Horarios'),
                  Tab(text: 'Rutas'),
                ],
              ),
            ),
            const Expanded(
                child: TabBarView(children: [
              //ContenidoInformacion(),
              ContenidoRuta(),
              ContenidoHorario(),
              ContenidoHorario(),
            ]))
          ],
        ),
      ),
    );
  }
}
