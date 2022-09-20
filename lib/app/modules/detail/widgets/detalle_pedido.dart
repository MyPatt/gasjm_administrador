import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/modules/detail/detail_controller.dart';
import 'package:get/get.dart';

class DettallePedido extends StatelessWidget {
  const DettallePedido({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailController>(
        builder: (_) => Scaffold(
              backgroundColor: AppTheme.background,

              //
              appBar: AppBar(
                backgroundColor: AppTheme.blueBackground,
                // actions: const [MenuAppBar()],
                title: Text(_.house.name),
              ),
            ) );
  }
}
