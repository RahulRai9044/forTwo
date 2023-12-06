import 'package:for_two/modules/dashboard/controller/dashboard_controller.dart';
import 'package:for_two/modules/wishlists/controller/new_wish_controller.dart';
import 'package:get/get.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}