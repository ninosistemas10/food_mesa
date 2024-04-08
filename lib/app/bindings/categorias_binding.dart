import 'package:dashboard_bloc/app/controller/categoria_controller.dart';
import 'package:get/get.dart';

class CategoriaBinding implements Bindings {
@override
void dependencies() {
    Get.lazyPut<CategoriaController>(() => CategoriaController());
    }
}