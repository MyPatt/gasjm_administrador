
import 'package:gasjm/app/modules/administrador/buscar/buscar_controller.dart';
import 'package:get/get.dart';

class BuscarAdministradorBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BuscarAdministradorController());
  }
}
