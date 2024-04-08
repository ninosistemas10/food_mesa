
import 'package:dashboard_bloc/app/controller/mesa_controller.dart';
import 'package:get/get.dart';

class MesaBinding implements Bindings {
@override
void dependencies() {
    Get.lazyPut<MesaController>(() => MesaController());
    }
}