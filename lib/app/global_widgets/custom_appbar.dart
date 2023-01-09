import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key, required this.title,
  }) : super(key: key);
  final Widget title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10),
        ),
      ),
      backgroundColor: AppTheme.blueBackground,
      // actions: const [MenuAppBar()],
      title: title,
    );
  }
}
