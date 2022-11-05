import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';

class ButtonSmall extends StatelessWidget {
  const ButtonSmall(
      {Key? key,
      required this.texto,
      required this.onTap,
      this.width = 145,
      this.color = AppTheme.blueBackground})
      : super(key: key);
  final void Function() onTap;
  final String texto;
  final double? width;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        
        width: width,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
          child: Text(texto,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.w500)
              // const TextStyle(color: Colors.white),
              ),
        ),
      ),
    );
  }
}
