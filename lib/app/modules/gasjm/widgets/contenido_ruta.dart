import 'package:flutter/material.dart';
import 'package:gasjm/app/modules/gasjm/gasjm_controller.dart';
import 'package:gasjm/app/modules/gasjm/widgets/form_ruta.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ContenidoRuta extends StatelessWidget {
  const ContenidoRuta({Key? key}) : super(key: key);

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
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: Responsive.getScreenSize(context).height * .05),
              SizedBox(
                height: 100,
                width: 100,
                child: SvgPicture.asset("assets/icons/ruta.svg",
                    semanticsLabel: 'Ruta'),
              ),
              SizedBox(height: Responsive.getScreenSize(context).height * .05),
              GetBuilder<GasJMController>(
                  builder: (_) => Obx(() => Expanded(
                      child: ListView.builder(
                          itemCount: _.listaHorarios.length,
                          itemBuilder: (context, index) {
                            return FormRuta(
                                horario: _.listaHorarios[index], modo: _.modo);
                          }))))
            ],
          ),
        ),
      ],
    );
  }
}
