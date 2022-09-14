import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool _isLoading = true.obs;
  RxBool get isLoading => _isLoading;
 
  RxInt isSelectedIndex = 0.obs; 
  RxInt isSelectedIndexFecha = 0.obs;

  selectedIndex(int index) {
    isSelectedIndex.value = index;
  }

  selectedIndexFecha(int index) {
    isSelectedIndexFecha.value = index;

    print(index);
  }
}
