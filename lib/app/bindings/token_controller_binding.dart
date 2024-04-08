
import 'package:get/get.dart';
import 'package:dashboard_bloc/app/controller/token_controller.dart';

class TokenAdminBindings implements Bindings {
    
    @override
    void dependencies(){
        Get.lazyPut<TokenAdminController>(() => TokenAdminController());
    }
}