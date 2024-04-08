
import 'package:dashboard_bloc/app/controller/notification_admin.dart';
import 'package:get/get.dart';

class NotificationAdminBinding implements Bindings {
@override
void dependencies() {
    Get.lazyPut<NotificationAdminController>(() => NotificationAdminController());
    }
}