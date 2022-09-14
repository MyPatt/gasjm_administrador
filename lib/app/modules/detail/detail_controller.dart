import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:dio/dio.dart';
import 'package:gasjm/app/data/models/estadopedido_model.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:get/get.dart';

class DetailController extends GetxController { 

  late PedidoModel _house  ;
  PedidoModel get house => _house;

  late String _date;

  @override
  void onInit() {
    print("onInit DetailController");
   
    this._house = Get.arguments as PedidoModel;

    print(_house.idCliente);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onChangedDate(String value) => _date = value;

  

  register() async {
    try {
      
      Get.back();
      Get.snackbar(
        'Message',
        'result',
        duration: Duration(seconds: 5),
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppTheme.cyan,
      );
    } on DioError catch (e) {
      Get.snackbar(
        'Message',
       "message",
        duration: Duration(seconds: 5),
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppTheme.cyan,
      );
    }
  }
}
