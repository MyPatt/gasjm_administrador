import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/data/controllers/pedido_controller.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart'; 
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class DetallePedido extends StatelessWidget {
  DetallePedido({Key? key, required this.e}) : super(key: key);
  final PedidoModel e;
  final PedidoController controladorDePedidos =
      Get.put(PedidoController());

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        backgroundColor: AppTheme.blueBackground,
        title: const Text(
          "Detalle del pedido",
        ),
        
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              height: Responsive.hp(context) * 0.9,
              child: ListView(children: [
                ///
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: Column(children: [
                  
                    SizedBox(height: 10.0),
                    const Divider(
                      thickness: 1.0,
                    ),
                    SizedBox(height: 10.0),
                  //  PedidosEnEsperaPage(idPedido: e.idPedido)
                  ]),
                ),
        
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
