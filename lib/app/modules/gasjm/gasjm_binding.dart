import 'package:gasjm/app/data/providers/horario_provider.dart';
import 'package:gasjm/app/data/repository/horario_repository.dart';
import 'package:gasjm/app/data/repository/implementations/horario_repository.dart';
import 'package:gasjm/app/modules/gasjm/gasjm_controller.dart';
import 'package:get/get.dart';

class GasJMBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<HorarioProvider>(HorarioProvider());

    Get.put<HorarioRepository>(HorarioRepositoryImpl());

    Get.lazyPut(() => GasJMController());
  }
}
