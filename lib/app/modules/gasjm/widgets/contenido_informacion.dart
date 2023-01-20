import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';

import 'package:gasjm/app/modules/gasjm/gasjm_controller.dart';
import 'package:gasjm/app/modules/gasjm/widgets/modal_editar.dart';
import 'package:gasjm/app/routes/app_routes.dart';
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
                    //Muestra la direccion de la distribuidora
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Nombre del lugar
                          Obx(
                            () => ElevatedButton.icon(
                                icon: const Icon(Icons.room_outlined),
                                label: Text(_.gasJM.value.nombreLugar ??
                                    'Distribuidora Gas j&M'),
                                clipBehavior: Clip.antiAlias,
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: Colors.white,
                                    foregroundColor: AppTheme.light),
                                    //se visualiza en el mapa 
                                    //  1er parametro  => direccion 
                                    //  2do parametro  => modo de edicion del mapa
                                    //  si esta en true solo  se visualiza la ubic... 
                                    //  y en false se puede cambiar nueva ubicacion

                                onPressed: () => Get.toNamed(
                                    AppRoutes.direccionDistribuidora,
                                    arguments: [_.gasJM.value.direccionGasJm,true])),
                          ),
                          //Icono para editar la ubicacion
                          Visibility(
                              //admin(0) puede editar, repartidor(1) solo ver
                              visible: _.modo == 0 ? true : false,
                              child: IconButton(
                                    //  y en false se puede cambiar nueva ubicacion

                                onPressed: () => Get.toNamed(
                                    AppRoutes.direccionDistribuidora,
                                    arguments:[ _.gasJM.value.direccionGasJm,false]),
                                icon: const Icon(
                                  Icons.mode_edit_outlined,
                                  size: 15,
                                  color: AppTheme.light,
                                ),
                              ))
                        ]),
                        //Muestra el numero de celular de la distribuidora
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //al tocar el numero se va al chat de wehatsapp
                          Obx(
                            () => ElevatedButton.icon(
                              icon: const Icon(Icons.whatsapp_outlined),
                              label: Text(
                                  _.gasJM.value.whatsappGasJm ?? 'Sin número'),
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: Colors.white,
                                  foregroundColor: AppTheme.light),
                              onPressed: () => _.abrirChatWhatsapp(),
                            ),
                          ),
                          //editar el numero
                          Visibility(
                              //admin(0) puede editar, repartidor(1) solo ver
                              visible: _.modo == 0 ? true : false,
                              child: IconButton(
                                onPressed: () => showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) {
                                      return const ModalEditarGasJm(
                                        nombreDato: 'celular',
                                      );
                                    }),
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
                          width: Responsive.wp(context) * .3,
                          height: 1.0,
                          //  margin: const EdgeInsets.only(bottom: 25.0),
                          decoration: BoxDecoration(
                            color: AppTheme.blueBackground,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        const TextSubtitle(
                          text: 'Producto',
                          color: AppTheme.light,
                        ),
                        Container(
                          width: Responsive.wp(context) * .3,
                          height: 1.0,
                          //  margin: const EdgeInsets.only(bottom: 25.0),
                          decoration: BoxDecoration(
                            color: AppTheme.blueBackground,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        height: Responsive.getScreenSize(context).height * .05),
                        //Datos del producto
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Nombre y precio
                        Obx(() => RichText(
                              text: TextSpan(
                                text: _.productoModel.value.nombreProducto,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
                                        color: AppTheme.blueDark,
                                        fontWeight: FontWeight.w700),
                                children: [
                                  TextSpan(
                                    text:
                                        '   \$ ${_.productoModel.value.precioProducto}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        ?.copyWith(
                                            color: AppTheme.light,
                                            fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            )),
                            //icono permite editar el precio del producto
                        Visibility(
                            //admin(0) puede editar, repartidor(1) solo ver
                            visible: _.modo == 0 ? true : false,
                            child: IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) {
                                      return const ModalEditarGasJm(
                                        nombreDato: 'producto',
                                      );
                                    });
                              },
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
