import 'package:gasjm/app/modules/editar_cliente/editar_cliente_controller.dart';
import 'package:get/get.dart';

class EditarClienteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditarClienteController());
  }
}
