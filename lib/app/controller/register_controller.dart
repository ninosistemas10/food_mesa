import 'dart:convert';
import 'package:dashboard_bloc/app/utils/api_endpoints.dart';
import 'package:dashboard_bloc/app/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    Future<void> registerWithEmail() async {
        try {
            var headers = {'Content-Type': 'application/json'};
            var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.registerEmail);
            Map body = {
                'nombre': nameController.text.trim(),
                'email': emailController.text.trim(),
                'password': passwordController.text
            };
            http.Response response = await http.post(url, body: jsonEncode(body), headers: headers);

            if (response.statusCode == 201) {
                final json = jsonDecode(response.body);
                //print('Response JSON: $json');
                final message = json['messages'] != null ? json['messages'][0] : null;
                if (message != null && message['code'] == 'record_created') {
                    Get.dialog(
                        SimpleDialog(
                            backgroundColor: AppColor.blueDark,
                            title: Text('Éxito', style: TextStyle(color: AppColor.blueLight),),
                            contentPadding: const EdgeInsets.all(20),
                            children: [Text('¡Se guardaron los cambios correctamente!', style: TextStyle(color: AppColor.green),)],
                        ),
                    );
                    Future.delayed(const Duration(seconds: 2), () {
                        Get.back();
                    });
                } else {
                    print('no hay mensaje');
                }
            } else {
                print('no limpio las casillas');
                print(response.statusCode);
                //throw jsonDecode(response.body)["Message"] ?? "Unknown Error Occurred";
            }
        } catch (e) {
            print('perdon para todos');
            Get.back();
            Get.dialog(
                SimpleDialog(
                    title: const Text('Error'),
                    contentPadding: const EdgeInsets.all(20),
                    children: [Text(e.toString())],
                ),
            );
        }
    }
}
