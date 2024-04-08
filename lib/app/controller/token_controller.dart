

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TokenAdminController extends GetxController{
    
    @override
    void onReady() {

        tokenName();
    super.onReady();
    }
    
    RxString token = RxString('');
    Future<void> tokenName() async{
        final box = GetStorage();
        String  tokenNombre = box.read('token') ?? '';
        token.value = tokenNombre;
        print(' tokencito: ${token.value}');
    }




}