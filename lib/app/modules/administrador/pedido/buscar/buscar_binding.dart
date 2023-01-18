
import 'package:gasjm/app/modules/administrador/pedido/buscar/buscar_controller.dart';
import 'package:get/get.dart';

class BuscarPedidosAdminBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BuscarPedidosAdminController());
  }
}
