import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/global_widgets/bottom_repartidor.dart';
import 'package:gasjm/app/global_widgets/menu_lateral.dart';
import 'package:gasjm/app/modules/repartidor/inicio/inicio_controller.dart';
import 'package:gasjm/app/modules/repartidor/inicio/widgets/explorar_mapa.dart';
import 'package:get/get.dart';
import 'package:gasjm/app/core/utils/globals.dart' as globals;

//Pantalla de inicio del cliente
class InicioPage extends StatelessWidget {
  InicioPage({key}) : super(key: key);
  final controller = InicioController();
//
  @override
  Widget build(BuildContext context) {
    return GetBuilder<InicioController>(
        builder: (_) => Scaffold(
            //Menú deslizable a la izquierda con opciones del  usuario
            drawer: MenuLateral(
              modo: 'Modo administrador',
              imagenPerfil: _.imagenUsuario,
            ),
            //Barra de herramientas de opciones para  agenda y  historial
            appBar: AppBar(
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
              ),
              backgroundColor: AppTheme.blueBackground,
              actions: <Widget>[
                IconButton(
                    onPressed: ()async   {
      String registrationToken =
                          "cOftmMesSHK-Tj_1kCkOs-:APA91bGmKjMQjXtDFEwtzVxZF8jjrGa4F0mjkUylQr9DuFWhYDEEsO4aCG39icSDgTENEYijJ0_c1181LOMX_QQsoHnLPEr9ghY_dcOAr8nQJET_2UgbtPVpzRLkIH0NEKt_67y3wmy2";

                      Map<String, String> mensaje = {
                        "titulo": "Titulo",
                        "cuerpo": "Cuerpo"
                      };
                      print("iiiiiiiiiiiiiiiiii");

                      await FirebaseMessaging.instance
                          .sendMessage(to: registrationToken, data: mensaje,messageId: "mensaje1");
                      print("pppppppppppppppppppppppppp"); 
                    },
                    icon: const Icon(Icons.notifications_on_outlined)),
                IconButton(
                    onPressed: () {
                      globals.existeNotificacion.value = false;
                    },
                    icon: Obx(
                      () => Icon(globals.existeNotificacion.value
                          ? Icons.notifications_active_outlined
                          : Icons.notifications_none_outlined),
                    )),
              ],
              // title: const Text('GasJ&M'),
              title: Text(globals.globalString ?? "GasJ&M"),
            ),
            //Body
            body: Stack(children: const <Widget>[
              //Widget Mapa
              Positioned.fill(child: ExplorarMapa())
            ]),
            //Navegacion del repartidor
            bottomNavigationBar:
                const BottomNavigationRepartidor(indiceActual: 0)));
  }
}
