import 'package:flutter/material.dart';
import 'package:gasjm/app/data/models/persona_model.dart';
import 'package:gasjm/app/global_widgets/imagen_usuario.dart';
import 'package:gasjm/app/global_widgets/modal_alert.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';

class CardPersona extends StatelessWidget {
  const CardPersona({Key? key, required this.persona,required this.editarDatosPersona, required this.eliminarPersona}) : super(key: key);
  final PersonaModel persona;
  final void Function() editarDatosPersona;
   final void Function()  eliminarPersona;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(right: 8.0, left: 8.0, top: 0.0, bottom: 0.0),
        child: Row(children: [
          ImagenUsuario(urlfotoPerfil: persona.fotoPersona ?? ''),
          Column(
            children: [
              TextSubtitle(
                text: '${persona.nombrePersona} ${persona.apellidoPersona}',
                textAlign: TextAlign.justify,
              ),
              TextDescription(
                  text: persona.cedulaPersona, textAlign: TextAlign.justify),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              IconButton(
                onPressed: editarDatosPersona,
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
                    _showDialogoParaEliminar(context, persona.uidPersona!),
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
          titulo: 'Eliminar cliente',
          mensaje: '¿Está seguro de eliminar?',
          icono: Icons.cancel_outlined,
        );
      },
    );
  }

//
  _eliminarPersona(BuildContext context, String id) {
    eliminarPersona();
    Navigator.of(context).pop();
  }
}
