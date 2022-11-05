import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';

class AlertRechazar extends StatelessWidget {
  const AlertRechazar({Key? key, required this.onPressed}) : super(key: key);
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const TextSubtitle(
        text: 'Rechazar pedido',
        textAlign: TextAlign.justify,
        //   style: TextoTheme.subtitleStyle2,
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: const <Widget>[
            TextDescription(text: '¿Está seguro de rechazar el pedido?')
          ],
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
