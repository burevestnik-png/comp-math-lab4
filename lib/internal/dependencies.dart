import 'package:get/get.dart';

class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<LogController>(LogController());
    Get.put<DrawingController>(DrawingController());
    Get.put<MainScreenState>(MainScreenState());
  }
}
