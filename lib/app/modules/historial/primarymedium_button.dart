import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';

class PrimaryMediumButton extends StatelessWidget {
  const PrimaryMediumButton({Key? key, 
    required this.texto,
    required this.onPressed,
  }) : super(key: key);
  final void Function() onPressed;
  final String texto;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: MaterialButton(
        color: AppTheme.blueBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        onPressed: onPressed,
        child: Text(
          texto,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
