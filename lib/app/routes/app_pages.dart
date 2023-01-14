import 'package:gasjm/app/modules/administrador/buscar/buscar_binding.dart';
import 'package:gasjm/app/modules/administrador/buscar/buscar_page.dart';
import 'package:gasjm/app/modules/administrador/cliente/cliente_binding.dart';
import 'package:gasjm/app/modules/administrador/cliente/cliente_page.dart';
import 'package:gasjm/app/modules/administrador/cliente/widgets/buscar_page.dart';
import 'package:gasjm/app/modules/administrador/detalle_persona/detalle_cliente_binding.dart';
import 'package:gasjm/app/modules/administrador/detalle_persona/detalle_persona_page.dart';
import 'package:gasjm/app/modules/administrador/vehiculo/detalle/detalle_binding.dart';
import 'package:gasjm/app/modules/administrador/vehiculo/detalle/detalle_page.dart';
import 'package:gasjm/app/modules/administrador/vehiculo/operacion/operacion_binding.dart';
import 'package:gasjm/app/modules/administrador/vehiculo/operacion/operacion_page.dart'; 
import 'package:gasjm/app/modules/administrador/vehiculo/registrar/registrar_binding.dart';
import 'package:gasjm/app/modules/administrador/vehiculo/registrar/registrar_page.dart';
import 'package:gasjm/app/modules/gasjm/gasjm_binding.dart';
import 'package:gasjm/app/modules/gasjm/gasjm_page.dart';
import 'package:gasjm/app/modules/administrador/inicio/inicio_binding.dart';
import 'package:gasjm/app/modules/administrador/inicio/inicio_page.dart';
import 'package:gasjm/app/modules/identificacion/identificacion_binding.dart';
import 'package:gasjm/app/modules/identificacion/identificacion_page.dart';
import 'package:gasjm/app/modules/repartidor/buscar/buscar_binding.dart';
import 'package:gasjm/app/modules/repartidor/buscar/buscar_page.dart';
import 'package:gasjm/app/modules/repartidor/inicio/inicio_binding.dart';
import 'package:gasjm/app/modules/repartidor/inicio/inicio_page.dart';
import 'package:gasjm/app/modules/repartidor/ir/ir_binding.dart';
import 'package:gasjm/app/modules/repartidor/ir/ir_page.dart';
import 'package:gasjm/app/modules/login/login_binding.dart';
import 'package:gasjm/app/modules/login/login_page.dart';
import 'package:gasjm/app/modules/administrador/operacion_pedido/pedido_binding.dart';
import 'package:gasjm/app/modules/administrador/operacion_pedido/pedido_page.dart';
import 'package:gasjm/app/modules/repartidor/pedidos/pedidos_binding.dart';
import 'package:gasjm/app/modules/repartidor/pedidos/pedidos_page.dart';
import 'package:gasjm/app/modules/perfil/perfil_binding.dart';
import 'package:gasjm/app/modules/perfil/perfil_page.dart';
import 'package:gasjm/app/modules/perfil/widgets/form_contrasena.dart';
import 'package:gasjm/app/modules/perfil/widgets/form_direccion.dart';
import 'package:gasjm/app/modules/registrar/registrar_binding.dart';
import 'package:gasjm/app/modules/registrar/registrar_page.dart';
import 'package:gasjm/app/modules/administrador/repartidor/repartidor_binding.dart';
import 'package:gasjm/app/modules/administrador/repartidor/repartidor_page.dart';
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
      page: () => const UbicacionPage(),
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
    //
    GetPage(
      name: AppRoutes.perfil,
      page: () => PerfilPage(),
      binding: PerfilBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.contrasena,
      page: () => const FormContrasena(),
      // binding: PerfilBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.direccion,
      page: () => const FormDireccion(),
      // binding: PerfilBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.gasjm,
      page: () => const GasJMPage(),
      binding: GasJMBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    //***** ADMIN *****
    GetPage(
      name: AppRoutes.inicioAdministrador,
      page: () => const InicioAdministradorPage(),
      binding: InicioAdministradorBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.repartidor,
      page: () => RepartidorPage(),
      binding: RepartidorBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),

    GetPage(
      name: AppRoutes.operacionPedido,
      page: () => const OperacionPedidoPage(),
      binding: OperacionPedidoBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
        name: AppRoutes.buscarPedidosAdmin,
        page: () => const BuscarAdministradorPage(),
        binding: BuscarAdministradorBinding(),
        transition: Transition.noTransition),
    GetPage(
        name: AppRoutes.buscarClienteAdmin,
        page: () => const BuscarClientePage(),
        binding: ClienteBinding(),
        transition: Transition.noTransition),
    GetPage(
      name: AppRoutes.cliente,
      page: () => const ClientePage(),
      binding: ClienteBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.detalleCliente,
      page: () => DetallePersonaPage(),
      binding: EditarClienteBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),

    //
    GetPage(
      name: AppRoutes.inicioRepartidor,
      page: () => InicioPage(),
      binding: InicioBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
        name: AppRoutes.buscarRepartidor,
        page: () => const BuscarRepartidorPage(),
        binding: BuscarBinding(),
        transition: Transition.noTransition),
    //Rutas para paginas de operaciones del vehiculo
    GetPage(
      name: AppRoutes.registrarVehiculo,
      page: () => const RegistrarVehiculoPage(),
      binding: RegistrarVehiculoBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.operacionVehiculo,
    page: () => const OperacionVehiculoPage(),
      binding: OperacionVehiculoBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.detalleVehiculo,
      page: () => const DetalleVehiculoPage(),
      binding: DetalleVehiculoBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    //***** REPARTIDOR *****

    GetPage(
        name: AppRoutes.ir,
        page: () => IrPage(),
        binding: IrBinding(),
        transition: Transition.noTransition),
    GetPage(
        name: AppRoutes.pedidos,
        page: () => const PedidosPage(),
        binding: PedidosBinding(),
        transition: Transition.noTransition),

    GetPage(
      name: AppRoutes.permission,
      page: () => const RequestPermissionPage(),
      binding: RequestPermissionBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
  ];
}
