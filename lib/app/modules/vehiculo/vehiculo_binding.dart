  
 
import 'package:gasjm/app/modules/vehiculo/vehiculo_controller.dart';
import 'package:get/get.dart';

class VehiculoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VehiculoController());
  }
}
