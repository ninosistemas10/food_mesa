import 'dart:convert';

import 'package:dashboard_bloc/app/controller/menu_controller.dart';
import 'package:dashboard_bloc/app/data/model/model_user/model_users.dart';
import 'package:dashboard_bloc/app/routes/pages.dart';
import 'package:dashboard_bloc/app/utils/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
//import 'package:shared_preferences/shared_preferences.dart';


class LoginController extends GetxController {
    final MenunController menunController = Get.find<MenunController>();
    @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
    
    TextEditingController emailCntrll = TextEditingController();
    TextEditingController passwordCntrll = TextEditingController();
   // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();


    Future<void>  loginWithEmail() async {
        


        var headers = {'Content-Type': 'application/json'};
        try {
            var url = Uri.parse( ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.loginEmail );
            Map<String, String> body = {
                'email': emailCntrll.text.trim(),
                'password': passwordCntrll.text
            };
            http.Response response = await http.post(url, body: jsonEncode(body), headers: headers);

            if (response.statusCode == 200) {
                final Map<String, dynamic> json = jsonDecode(response.body);
                final ModelUsers modelUsers = ModelUsers.fromJson(json);

    
                var token = modelUsers.data.token;
                var user = modelUsers.data.user;

            // Puedes usar 'token' y 'user' en tu aplicación
                print('Token: $token');
                print('Nombre: ${user.nombre}');
                print('User ID: ${user.id}');
                print('User Email: ${user.email}');
                //print('User Nombre: ${user.isAdmin}');
                menunController.token.value = token;
                print(token);
                if (user.isAdmin == true) {
                    
                    print('User isAdmin: si');
                }else {
                    print('User isAdmin: no');
                }
                
                emailCntrll.clear();
                passwordCntrll.clear();
                
                final box = GetStorage();
                await box.write('nombre', user.nombre);
                await box.write('token', token);
            

                Get.offAllNamed(Routes.dashboard);

            } else {
                throw 'Error en el inisio de sesion';
            }
        
           // throw jsonDecode(response.body)["Message"] ?? "Unknown Error Occurred";
            
        } catch (error) {
            Get.back();
            showDialog(
                context: Get.context!,
                builder: (context) {
                    return SimpleDialog(
                        title: const Text('Error'),
                        contentPadding: const EdgeInsets.all(20),
                        children: [Text(error.toString())],
                    );
                },
            );
        }
    }    
}
