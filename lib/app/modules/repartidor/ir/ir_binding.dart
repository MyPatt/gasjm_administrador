import 'package:gasjm/app/data/controllers/usuario_controller.dart';
import 'package:gasjm/app/modules/repartidor/ir/ir_controller.dart';
import 'package:get/get.dart';

class IrBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IrController());

    Get.lazyPut(() => UsuarioController());
  }
}
