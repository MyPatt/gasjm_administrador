import 'package:gasjm/app/data/providers/estadopedido_provider.dart';
import 'package:gasjm/app/data/providers/notificacion_provider.dart';
import 'package:gasjm/app/data/providers/pedido_provider.dart';
import 'package:gasjm/app/data/providers/perfil_provider.dart';
import 'package:gasjm/app/data/providers/persona_provider.dart';
import 'package:gasjm/app/data/providers/producto_provider.dart';
import 'package:gasjm/app/data/repository/estadopedido_repository.dart';
import 'package:gasjm/app/data/repository/implementations/estadopedido_repository.dart';
import 'package:gasjm/app/data/repository/implementations/notificacion_repository.dart';
import 'package:gasjm/app/data/repository/implementations/pedido_repository.dart';
import 'package:gasjm/app/data/repository/implementations/perfil_repository.dart';
import 'package:gasjm/app/data/repository/implementations/persona_repository.dart';
import 'package:gasjm/app/data/repository/implementations/producto_repository.dart';
import 'package:gasjm/app/data/repository/notificacion_repository.dart';
import 'package:gasjm/app/data/repository/pedido_repository.dart';
import 'package:gasjm/app/data/repository/perfil_repository.dart';
import 'package:gasjm/app/data/repository/persona_repository.dart';
import 'package:gasjm/app/data/repository/producto_repository.dart';
import 'package:gasjm/app/data/providers/horario_provider.dart';
import 'package:gasjm/app/data/repository/horario_repository.dart';
import 'package:gasjm/app/data/repository/implementations/horario_repository.dart';
import 'package:gasjm/app/data/providers/vehiculo_provider.dart';
import 'package:gasjm/app/data/repository/implementations/vehiculo_repository.dart';
import 'package:gasjm/app/data/repository/vehiculo_repository.dart';
import 'package:get/get.dart';

class DependencyInjection {
  static void load() async {
    //Providers
    Get.put<PedidoProvider>(PedidoProvider());
    Get.put<ProductoProvider>(ProductoProvider());
    Get.put<EstadoPedidoProvider>(EstadoPedidoProvider());
    Get.put<PerfilProvider>(PerfilProvider());
    Get.put<PersonaProvider>(PersonaProvider());
    Get.put<GasJMProvider>(GasJMProvider());
    Get.put<NotificacionProvider>(NotificacionProvider());
    Get.put<VehiculoProvider>(VehiculoProvider());
    //Local

    //Respositories

    Get.put<PedidoRepository>(PedidoRepositoryImpl());
    Get.put<ProductoRepository>(ProductoRepositoryImpl());
    Get.put<EstadoPedidoRepository>(EstadoPedidoRepositoryImpl());
    Get.put<PerfilRepository>(PerfilRepositoryImpl());
    Get.put<PersonaRepository>(PersonaRepositoryImpl());
    Get.put<GasJMRepository>(GasJMRepositoryImpl());
    Get.put<NotificacionRepository>(NotificacionRepositoryImpl());
    Get.put<VehiculoRepository>(VehiculoRepositoryImpl());

    //Local
  }
}
