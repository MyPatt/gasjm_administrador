import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';

class ButtonFavorite extends StatelessWidget {
  const ButtonFavorite({
    Key? key,
    this.size = 90,
    this.child,
    this.onTap,
  }) : super(key: key);
  final double size;
  final Widget? child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: size,
          padding:const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: AppTheme.blueBackground,
            ),
          ),
          child: child),
    );
  }
}
