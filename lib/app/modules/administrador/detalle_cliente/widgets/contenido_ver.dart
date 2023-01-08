import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/modules/administrador/detalle_cliente/widgets/contenido_historial.dart';
import 'package:gasjm/app/modules/administrador/detalle_cliente/widgets/contenido_perfil.dart';
import 'package:flutter/material.dart';

class ContenidoVer extends StatelessWidget {
  const ContenidoVer({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: const TabBar(
                indicatorColor: AppTheme.blueBackground,
                labelColor: AppTheme.blueBackground,
                unselectedLabelColor: AppTheme.light,
                tabs: <Widget>[
                  Tab(text: "Perfil"),
                  Tab(
                    text: "Historial",
                  )
                ],
              ),
            ),
            const Expanded(
                child: TabBarView(
                    children: [ContenidoPerfil(), ContenidoHistorial()]))
          ],
        ));
  }
}
