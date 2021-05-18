import 'package:get/get.dart';
import 'package:visab_admin/controller/admin_auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AdminAuthController>(AdminAuthController(), permanent: true);
  }
}