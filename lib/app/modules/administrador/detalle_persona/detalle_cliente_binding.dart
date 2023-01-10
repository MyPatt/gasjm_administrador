import 'package:gasjm/app/modules/administrador/detalle_persona/detalle_persona_controller.dart';
import 'package:get/get.dart';

class EditarClienteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetallePersonaController());
  }
}
