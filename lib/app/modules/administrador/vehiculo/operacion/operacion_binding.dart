import 'package:gasjm/app/modules/administrador/vehiculo/operacion/operacion_controller.dart';
import 'package:get/get.dart';

class OperacionVehiculoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OperacionVehiculoController());
  }
}
