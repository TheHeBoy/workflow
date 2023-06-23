import 'package:get/get.dart';
import 'logic.dart';


class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
          () => HomeController(),
      fenix: true,
    );
  }
}
