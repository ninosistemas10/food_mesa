import 'package:dashboard_bloc/app/controller/data_categoria_controller.dart';
import 'package:get/get.dart';

class DataBindings implements Bindings {
    
    @override
    void dependencies(){
        Get.lazyPut<DataCategoriaController>(() => DataCategoriaController());
    }
}