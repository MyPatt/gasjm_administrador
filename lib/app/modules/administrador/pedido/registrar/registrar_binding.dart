 
import 'package:gasjm/app/modules/administrador/pedido/registrar/registrar_controller.dart';
import 'package:get/get.dart';

class RegistrarPedidoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegistrarPedidoController());
  }
}
