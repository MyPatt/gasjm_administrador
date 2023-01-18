import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/global_widgets/handle.dart';
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
              Expanded(
                  child: GetBuilder<GasJMController>(
                builder: (_) => Column(
                  children: [
                    Row(children: [
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.room_outlined),
                        label: Text(
                            _.gasJM?.direccionGasJm ?? 'Distribuidora Gas j&M'),
                        clipBehavior: Clip.antiAlias,
                      ),
                      Visibility(
                          //admin(0) puede editar, repartidor(1) solo ver
                          visible: _.modo == 0 ? true : false,
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.mode_edit_outlined,
                              size: 15,
                            ),
                          ))
                    ]),
                    SizedBox(
                        height: Responsive.getScreenSize(context).height * .02),
                    Row(children: [
                      ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.whatsapp_outlined),
                          label: Text(_.gasJM?.whatsappGasJm ?? 'Sin número')),
                      Visibility(
                          //admin(0) puede editar, repartidor(1) solo ver
                          visible: _.modo == 0 ? true : false,
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.mode_edit_outlined,
                              size: 15,
                            ),
                          ))
                    ]),
                    SizedBox(
                        height: Responsive.getScreenSize(context).height * .05),
                    Row(
                      children: const [
                        Handle(),
                        TextDescription(text: 'Producto'),
                        Handle(),
                      ],
                    ),
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: _.productoModel?.nombreProducto ??
                                'Gas doméstico',
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(
                                    color: AppTheme.blueDark,
                                    fontWeight: FontWeight.w900),
                            children: [
                              TextSpan(
                                text: _.productoModel?.precioProducto
                                        .toString() ??
                                    'Sin precio',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900),
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
