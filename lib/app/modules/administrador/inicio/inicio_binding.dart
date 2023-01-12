
import 'package:gasjm/app/modules/administrador/inicio/inicio_controller.dart';
import 'package:get/get.dart';

class InicioAdministradorBinding extends Bindings {
  @override
  void dependencies() { 


    //
    Get.lazyPut(() => InicioAdministradorController());
  }
}
