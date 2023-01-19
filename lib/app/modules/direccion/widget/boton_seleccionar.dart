import 'package:flutter/material.dart';
import 'package:gasjm/app/global_widgets/primary_button.dart';

class BotonSeleccionar extends StatelessWidget {
  const BotonSeleccionar({
    Key? key, required this.onPressed,
  }) : super(key: key);
final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            child: PrimaryButton(
                texto: "Guardar",
                onPressed: onPressed)));
  }
}
