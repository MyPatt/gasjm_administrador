
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/modules/detail/detail_controller.dart';
import 'package:gasjm/app/modules/detail/widgets/appbar_actions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/content.dart';
import 'widgets/footer.dart';
import 'widgets/header.dart';
import 'package:meta/meta.dart' show required;

class DetailPage extends StatelessWidget {
  DetailPage({
      this.house,
  });

  final PedidoModel? house;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailController>(
      builder: (_) => Scaffold(
        body: Stack(
          children: [
            Header(paths: "assets/icons/identificacion.png"),
            AppBarActions(),
            Content(house: _.house),
            Footer(house: _.house),
          ],
        ),
      ),
    );
  }
}
