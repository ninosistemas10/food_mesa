

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class NotificationAdminController extends GetxController{

    @override
    void onReady() {

        namedUser();
    super.onReady();
    }
    RxString nombre = RxString('');
    Future<void> namedUser() async{
        final box = GetStorage();
        String  userNombre = box.read('nombre') ?? '';
        nombre.value = userNombre;
        print('nombrsito :$nombre.value');
    }




}