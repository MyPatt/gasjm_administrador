 
import 'package:gasjm/app/modules/operacion_pedido/pedido_controller.dart';
import 'package:get/get.dart';

class ClienteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OperacionPedidoController());
  }
}
