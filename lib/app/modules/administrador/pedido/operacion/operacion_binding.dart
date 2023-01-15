import 'package:gasjm/app/modules/administrador/pedido/operacion/operacion_controller.dart';

import 'package:get/get.dart';

class OperacionPedidoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OperacionPedidoController());
  }
}
