import 'package:for_two/modules/dashboard/controller/dashboard_controller.dart';
import 'package:for_two/modules/dashboard/controller/new_meeting_controller.dart';
import 'package:get/get.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<NewMeetingController>(() => NewMeetingController());
  }
}