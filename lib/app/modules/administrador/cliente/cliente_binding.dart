import 'package:gasjm/app/modules/administrador/cliente/cliente_controller.dart';
import 'package:get/get.dart';

class ClienteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ClienteController());
  }
}
