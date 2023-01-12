import 'package:flutter/material.dart';
import 'package:gasjm/app/data/models/vehiculo_model.dart';
import 'package:gasjm/app/global_widgets/imagen_usuario.dart';
import 'package:gasjm/app/global_widgets/modal_alert.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';

class CardVehiculo extends StatelessWidget {
  const CardVehiculo({Key? key, required this.vehiculo,required this.editarDatosVehiculo, required this.eliminarVehiculo, required this.verDatosVehiculo}) : super(key: key);
  final Vehiculo vehiculo;
  final void Function() verDatosVehiculo;
  final void Function() editarDatosVehiculo;
   final void Function()  eliminarVehiculo;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: verDatosVehiculo,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(right: 8.0, left: 8.0, top: 0.0, bottom: 0.0),
          child: Row(children: [
            ImagenUsuario(urlfotoPerfil: vehiculo.fotoVehiculo ?? ''),
            Column(
              children: [
                TextSubtitle(
                  text: '${vehiculo.placaVehiculo} ',
                  textAlign: TextAlign.justify,
                ),
                TextDescription(
                    text: '${vehiculo.marcaVehiculo} ${vehiculo.modeloVehiculo}', textAlign: TextAlign.justify),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                IconButton(
                  onPressed: editarDatosVehiculo,
                 /* onPressed: () {
                    Get.toNamed(AppRoutes.detalleCliente,
                        arguments: [persona, true]);
                  },*/
                  icon: const Icon(
                    Icons.mode_edit_outline_outlined,
                    color: Colors.black38,
                    size: 20,
                  ),
                ),
                IconButton(
                  onPressed: () =>
                      _showDialogoParaEliminar(context, vehiculo.idVehiculo!),
                  icon: const Icon(
                    Icons.delete_outline_outlined,
                    color: Colors.black38,
                    size: 20,
                  ),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }

  //Dialog para eliminar
  _showDialogoParaEliminar(BuildContext context, String idPersona) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ModalAlert(
          onPressed: () => _eliminarPersona(context, idPersona),
          titulo: 'Eliminar vehículo',
          mensaje: '¿Está seguro de eliminar?',
          icono: Icons.cancel_outlined,
        );
      },
    );
  }

//
  _eliminarPersona(BuildContext context, String id) {
    eliminarVehiculo();
    Navigator.of(context).pop();
  }
}
