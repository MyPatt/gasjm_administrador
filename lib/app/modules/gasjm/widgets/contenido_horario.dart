
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart'; 
import 'package:gasjm/app/modules/gasjm/gasjm_controller.dart';
import 'package:gasjm/app/modules/gasjm/widgets/form_horario.dart';
import 'package:get/get.dart';

class ContenidoHorario extends StatelessWidget {
  ContenidoHorario({Key? key, required this.modo}) : super(key: key);
  final GasJMController _ = Get.put(GasJMController());
  final int modo;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          alignment: Alignment.center,
          //height: Responsive.hp(context),
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                backgroundColor: AppTheme.light,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.backup_table_rounded,
                    color: AppTheme.blueDark,
                    size: 50,
                  ),
                  radius: 55.0,
                ),
                radius: 56.0,
              ),
              //    SizedBox(height: Responsive.getScreenSize(context).height * .05),
              Obx(() => Expanded(
                  child: ListView.builder(
                      // scrollDirection: Axis.horizontal,
                      itemCount: _.listaHorarios.length,
                      itemBuilder: (context, index) {
                        return FormHorario(horario: _.listaHorarios[index], modo:modo);
                      })))
            ],
          ),
        ),
      ],
    );
  }
}
