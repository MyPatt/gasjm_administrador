 
import 'package:gasjm/app/modules/administrador/vehiculo/registrar/registrar_controller.dart';
import 'package:get/get.dart';

class RegistrarVehiculoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegistrarVehiculoController());
  }
}
