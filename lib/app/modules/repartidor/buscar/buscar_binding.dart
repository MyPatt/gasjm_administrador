import 'package:gasjm/app/modules/repartidor/buscar/buscar_controller.dart';
import 'package:get/get.dart';

class BuscarBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BuscarRepartidorController());
  }
}
