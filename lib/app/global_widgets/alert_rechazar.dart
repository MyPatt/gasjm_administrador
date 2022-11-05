import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
//Muestra un dialogo modal con las opciones si o no
class AlertDialogConfirmacion extends StatelessWidget {
  const AlertDialogConfirmacion(
      {Key? key,
      required this.onPressed,
      required this.titulo,
      required this.mensaje})
      : super(key: key);
  final String titulo;
  final String mensaje;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: TextSubtitle(
        text: titulo,
        textAlign: TextAlign.justify,
        //   style: TextoTheme.subtitleStyle2,
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[TextDescription(text: mensaje)],
        ),
      ),
      actionsAlignment: MainAxisAlignment.end,
      actions: <Widget>[
        TextButton(
          child: const Text(
            'No',
            style: TextStyle(
              color: AppTheme.light,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text(
            'Si ',
            style: TextStyle(
              color: AppTheme.blueBackground,
            ),
          ),
          onPressed: onPressed,
        ),
      ],
    );
  }
}
