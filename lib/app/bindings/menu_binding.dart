import 'package:dashboard_bloc/app/controller/menu_controller.dart';
import 'package:get/get.dart';

class MenuBinding implements Bindings {
@override
void dependencies() {
    Get.lazyPut<MenunController>(() => MenunController());
    }
}