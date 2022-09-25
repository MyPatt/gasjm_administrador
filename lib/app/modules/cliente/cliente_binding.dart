import 'package:gasjm/app/modules/detail/detail_controller.dart';
import 'package:get/get.dart';

class ClienteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailController());
  }
}
