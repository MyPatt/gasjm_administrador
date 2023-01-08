import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart'; 

class UbicacionController extends GetxController {

  //
  final cargando = RxBool(false);
  //PermissionStatus _status;
 /*
  RxBool _isOscure = true.obs;
  RxBool get isOscure => _isOscure;
  @override
  void onInit() {
    super.onInit();
    //
    /* PermissionHandler()
        .checkPermissionStatus(PermissionGroup.locationWhenInUse)
        .then(_updateStatus);*/
  }

 */

  cargarIdentificacion() async {
 
      await Future.delayed(const Duration(seconds: 1));
      Get.toNamed(AppRoutes.identificacion);
     
  }  cargarUbicacion() async {
     
      await Future.delayed(const Duration(seconds: 1));
      Get.toNamed(AppRoutes.ubicacion);
  
  }
/*
  void _updateStatus(PermissionStatus status) {
    if (status != _status) {
      setState(() {
        _status = status;
      });
    }
  }*/
}
