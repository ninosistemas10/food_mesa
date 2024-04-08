
import 'package:dashboard_bloc/app/controller/register_controller.dart';
import 'package:get/get.dart';

class RegisterBinding implements Bindings {
@override
void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController());
    }
}