/*import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';

import 'package:gasjm/app/modules/gasjm/gasjm_controller.dart';
import 'package:get/get.dart';

class ContenidoInformacion extends StatelessWidget {
  const ContenidoInformacion({Key? key}) : super(key: key);

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
              SizedBox(height: Responsive.getScreenSize(context).height * .05),
              SizedBox(
                height: 100,
                width: 100,
                child: SvgPicture.asset("assets/icons/iconogasjm.svg",
                    semanticsLabel: 'Informacion Gas J&M'),
              ),
              SizedBox(height: Responsive.getScreenSize(context).height * .05),
              (GetBuilder<GasJMController>(
                builder: (_) => Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton.icon(
                            icon: const Icon(Icons.room_outlined),
                            label: Text(_.gasJM.direccionGasJm ??
                                'Distribuidora Gas j&M'),
                            clipBehavior: Clip.antiAlias,
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: Colors.white,
                                onPrimary: AppTheme.light),
                            onPressed: () {},
                          ),
                          Visibility(
                              //admin(0) puede editar, repartidor(1) solo ver
                              visible: _.modo == 0 ? true : false,
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.mode_edit_outlined,
                                  size: 15,
                                  color: AppTheme.light,
                                ),
                              ))
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton.icon(
                            icon: const Icon(Icons.whatsapp_outlined),
                            label: Text(_.gasJM.whatsappGasJm ?? 'Sin número'),
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: Colors.white,
                                onPrimary: AppTheme.light),
                            onPressed: () {},
                          ),
                          Visibility(
                              //admin(0) puede editar, repartidor(1) solo ver
                              visible: _.modo == 0 ? true : false,
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.mode_edit_outlined,
                                  size: 15,
                                  color: AppTheme.light,
                                ),
                              ))
                        ]),
                    SizedBox(
                        height: Responsive.getScreenSize(context).height * .05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Handle(),
                        Container(
                          width: Responsive.wp(context) * .25,
                          height: 3.0,
                          //  margin: const EdgeInsets.only(bottom: 25.0),
                          decoration: BoxDecoration(
                            color: AppTheme.light,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        const TextDescription(text: 'Producto'),
                        Container(
                          width: Responsive.wp(context) * .25,
                          height: 3.0,
                          //  margin: const EdgeInsets.only(bottom: 25.0),
                          decoration: BoxDecoration(
                            color: AppTheme.light,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: _.productoModel.nombreProducto,
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(
                                    color: AppTheme.blueDark,
                                    fontWeight: FontWeight.w700),
                            children: [
                              TextSpan(
                                text: ' ${_.productoModel.precioProducto}',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
                                        color: AppTheme.light,
                                        fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                            //admin(0) puede editar, repartidor(1) solo ver
                            visible: _.modo == 0 ? true : false,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.mode_edit_outlined,
                                size: 15,
                                color: AppTheme.light,
                              ),
                            ))
                      ],
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ],
    );
  }
}
*/