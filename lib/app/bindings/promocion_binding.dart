
import 'package:dashboard_bloc/app/controller/data_promocion_controller.dart';
import 'package:get/get.dart';

class DataPromocionBinding implements Bindings {
@override
void dependencies() {
    Get.lazyPut<DataPromocionController>(() => DataPromocionController());
    }
}