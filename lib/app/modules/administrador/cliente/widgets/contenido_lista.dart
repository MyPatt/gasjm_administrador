import 'package:flutter/material.dart';
import 'package:gasjm/app/data/models/persona_model.dart';
import 'package:gasjm/app/global_widgets/modal_alert.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
import 'package:gasjm/app/modules/administrador/cliente/widgets/imagen_usuario.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';

class ContenidoLista extends StatelessWidget {
  const ContenidoLista(
      {Key? key,
      required this.persona,
      required this.onPressed,
      required this.eliminarCliente})
      : super(key: key);
  final PersonaModel persona;
  final void Function()? onPressed;
  final void Function() eliminarCliente;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              right: 8.0, left: 8.0, top: 4.0, bottom: 4.0),
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
                  onPressed: () {
                    Get.toNamed(AppRoutes.detalleCliente,
                        arguments: [persona, true]);
                  },
                  icon: const Icon(
                    Icons.mode_edit_outline_outlined,
                    color: Colors.black38,
                    size: 15,
                  ),
                ),
                IconButton(
                  onPressed: () =>
                      _showDialogoParaEliminar(context, persona.uidPersona!),
                  icon: const Icon(
                    Icons.delete_outline_outlined,
                    color: Colors.black38,
                    size: 15,
                  ),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }

//
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
    eliminarCliente;
    Navigator.of(context).pop();
  }
}
