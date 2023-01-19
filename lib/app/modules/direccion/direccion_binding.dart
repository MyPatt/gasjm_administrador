import 'package:gasjm/app/modules/direccion/direccion_controller.dart';
 
import 'package:get/get.dart';

class DireccionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DirecccionController());
  }
}
