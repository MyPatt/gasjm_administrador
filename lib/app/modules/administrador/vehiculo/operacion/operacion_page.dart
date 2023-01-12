import 'package:flutter/material.dart';
import 'package:gasjm/app/global_widgets/bottom_administrador.dart';
import 'package:gasjm/app/global_widgets/menu_lateral.dart';
import 'package:gasjm/app/modules/administrador/vehiculo/operacion/operacion_controller.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/modules/administrador/vehiculo/operacion/widgets/lista_vehiculos.dart';
import 'package:get/get.dart';

class OperacionVehiculoPage extends StatelessWidget {
  const OperacionVehiculoPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.background,
        appBar: AppBar(
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          backgroundColor: AppTheme.blueBackground,
          // actions: const [MenuAppBar()],
          title: const Text('Vehículos'),
        ),
        /*    drawer: GetBuilder<OperacionVehiculoController>(
          builder: (_) => MenuLateral(
              modo: 'Modo repartidor', imagenPerfil: _.imagenPerfil),
        ),*/
        body: Container()
        //const ListaVehiculos(),
        /* bottomNavigationBar:
            const BottomNavigationAdministrador(indiceActual: 2)
            */
        );
  }
}
/*
Widget _cardRepartidor(
    PersonaModel persona, VehiculoController controladorDePedidos) {
  return Padding(
    padding:
        const EdgeInsets.only(right: 8.0, left: 8.0, top: 4.0, bottom: 4.0),
    child: Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(color: AppTheme.light, width: 0.5),
      ),
      child: ListTile(
        style: ListTileStyle.list,
        iconColor: AppTheme.light,
        leading: const Icon(
          Icons.car_rental_outlined,
          //  size: 30,
        ),
        title: const TextSubtitle(
          //   text: '${persona.nombrePersona} ${persona.apellidoPersona}',
          text: "ASZ0950",
          textAlign: TextAlign.justify,
        ),
        subtitle: const TextDescription(
            //text: persona.cedulaPersona,
            text: "Hino 2018",
            textAlign: TextAlign.justify),
        trailing: IconButton(
            onPressed: () {
              controladorDePedidos.cargarDetalleDelRepartidor(persona);
            },
            icon: const Icon(
              Icons.keyboard_arrow_right_outlined,
              // size: 30,
            )),
      ),
    ),
  );
}
*/