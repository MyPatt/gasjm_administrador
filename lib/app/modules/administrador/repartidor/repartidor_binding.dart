  
import 'package:gasjm/app/modules/administrador/repartidor/repartidor_controller.dart';
import 'package:get/get.dart';

class RepartidorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RepartidorController());
  }
}
