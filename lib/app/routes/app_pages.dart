 
import 'package:gasjm/app/modules/agenda/cliente/agenda_cliente_binding.dart';
import 'package:gasjm/app/modules/agenda/cliente/agenda_cliente_page.dart';
import 'package:gasjm/app/modules/agenda/cliente/local_widgets/editar/editar_binding.dart';
import 'package:gasjm/app/modules/agenda/cliente/local_widgets/editar/editar_page.dart';
import 'package:gasjm/app/modules/cliente/cliente_binding.dart';
import 'package:gasjm/app/modules/cliente/cliente_page.dart';
import 'package:gasjm/app/modules/detail/detail_binding.dart';
import 'package:gasjm/app/modules/detail/detail_page.dart';
import 'package:gasjm/app/modules/home/home_binding.dart';
import 'package:gasjm/app/modules/home/home_page.dart';
import 'package:gasjm/app/modules/identificacion/identificacion_binding.dart';
import 'package:gasjm/app/modules/identificacion/identificacion_page.dart';
import 'package:gasjm/app/modules/inicio/inicio_binding.dart';
import 'package:gasjm/app/modules/inicio/inicio_page.dart';
import 'package:gasjm/app/modules/ir/ir_binding.dart';
import 'package:gasjm/app/modules/ir/ir_page.dart'; 
import 'package:gasjm/app/modules/login/login_binding.dart';
import 'package:gasjm/app/modules/login/login_page.dart';
import 'package:gasjm/app/modules/pedidos/pedidos_binding.dart';
import 'package:gasjm/app/modules/pedidos/pedidos_page.dart'; 
import 'package:gasjm/app/modules/registrar/registrar_binding.dart';
import 'package:gasjm/app/modules/registrar/registrar_page.dart';
import 'package:gasjm/app/modules/request_permission/request_permission_binding.dart';
import 'package:gasjm/app/modules/request_permission/request_permission_page.dart';
import 'package:gasjm/app/modules/splash/splash_binding.dart';
import 'package:gasjm/app/modules/splash/splash_page.dart';
import 'package:gasjm/app/modules/ubicacion/ubicacion_binding.dart';
import 'package:gasjm/app/modules/ubicacion/ubicacion_page.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.ubicacion,
      page: () =>const UbicacionPage(),
      binding: UbicacionBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.identificacion,
      page: () => const IdentificacionPage(),
      binding: IdentificacionBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
 
    GetPage(
      name: AppRoutes.registrar,
      page: () => const RegistrarPage(),
      binding: RegistrarBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
      GetPage(
      name: AppRoutes.inicio,
      page: () =>  const HomePage(),
      binding: HomeBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ), 
     GetPage(
      name: AppRoutes.detail,
      page: () =>  const DetailPage(),
      binding: DetailBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
     GetPage(
      name: AppRoutes.cliente,
      page: () =>   ClientePage(),
      binding: ClienteBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ), 
    GetPage(
      name: AppRoutes.inicioRepartidor,
      page: () =>  InicioPage(),
      binding: InicioBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ), 
     GetPage(
      name: AppRoutes.ir,
      page: () =>  IrPage(),
      binding: IrBinding(),
      transition: Transition.noTransition
    ),  GetPage(
      name: AppRoutes.pedidos,
      page: () => const PedidosPage(),
      binding: PedidosBinding(),
      transition: Transition.noTransition
    ),
    GetPage(
      name: AppRoutes.agenda,
      page: () => const AgendaClientePage(),
      binding: AgendaClienteBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),

    GetPage(
      name: AppRoutes.editaragenda,
      page: () => const EditarAgendaPage(),
      binding: EditarPedidoAgendadoBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.permission,
      page: () => const RequestPermissionPage(),
      binding: RequestPermissionBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),

    
  ];
}
