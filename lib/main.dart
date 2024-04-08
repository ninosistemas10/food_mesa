

import 'package:dashboard_bloc/app/bindings/login.binding.dart';
import 'package:dashboard_bloc/app/controller/data_categoria_controller.dart';
import 'package:dashboard_bloc/app/controller/data_mesa_controller.dart';
import 'package:dashboard_bloc/app/controller/menu_controller.dart';
import 'package:dashboard_bloc/app/controller/mesa_controller.dart';
import 'package:dashboard_bloc/app/controller/register_controller.dart';
import 'package:dashboard_bloc/app/controller/token_controller.dart';
import 'package:dashboard_bloc/app/presentation/mesas/mesa_null.dart';
import 'package:dashboard_bloc/app/routes/pages.dart';
import 'package:dashboard_bloc/app/utils/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main()  async{
    WidgetsFlutterBinding.ensureInitialized();
    await GetStorage.init(); 


   
     Get.put(MenunController()); 
     Get.put(DataCategoriaController());
     Get.put(TokenAdminController());
     //Get.put(PromocionController());
     Get.put(LoginmmController());
     Get.put(RegisterController()); 
    Get.put(MesaController());
    Get.put(DataMesaController());
    // Get.put(SubCategoriaController());
   // Get.put(TokenAdminController());  //inicializa el getStorage
    runApp(
        GetMaterialApp(
            
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.initial,
            theme: appThemeDataLight,
            defaultTransition: Transition.fade,
            
            initialBinding: LoginBinding(),
            getPages: RoutesClass.routes,
            
            
        )
    );
}

