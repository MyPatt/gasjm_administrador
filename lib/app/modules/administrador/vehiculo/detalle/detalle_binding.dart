 
import 'package:gasjm/app/modules/administrador/vehiculo/detalle/detalle_controller.dart';
import 'package:get/get.dart';

class DetalleVehiculoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetalleVehiculoController());
  }
}
