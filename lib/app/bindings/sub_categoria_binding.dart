


import 'package:dashboard_bloc/app/controller/sub_categoria_controller.dart';

import 'package:get/get.dart';

class SubCategoriaBinding implements Bindings {
@override
void dependencies() {
    Get.lazyPut<SubCategoriaController>(() => SubCategoriaController());
    }
}