
import 'package:dashboard_bloc/app/presentation/mesas/mesa_null.dart';
import 'package:get/get.dart';

class DataBindings implements Bindings {
    
    @override
    void dependencies(){
        Get.lazyPut<LoginmmController>(() => LoginmmController());
    }
}