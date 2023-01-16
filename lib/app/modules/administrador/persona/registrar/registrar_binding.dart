 

import 'package:gasjm/app/modules/administrador/persona/registrar/registrar_controller.dart';
import 'package:get/get.dart';

class RegistrarPersonaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegistrarPersonaController());
  }
}
