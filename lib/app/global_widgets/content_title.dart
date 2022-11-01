import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';

class Subtitulo extends StatelessWidget {
  const Subtitulo({
    Key? key,
    required this.title,
    required this.more,
    required this.onTap,
  }) : super(key: key);
  final String title;
  final String more;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.all(20.00),
        child: Row(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  color: AppTheme.blueDark, fontWeight: FontWeight.w700),
            ),
            const Spacer(),
            GestureDetector(
                onTap: onTap,
                child: Row(children: [
                  Text(
                    more,
                    style: Theme.of(context).textTheme.caption?.copyWith(
                        color: AppTheme.blueDark, fontWeight: FontWeight.w700),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: AppTheme.blueDark,
                    size: 14.0,
                  )
                ]))
          ],
        ),
      ),
    );
  }
}
