import 'dart:convert';

import 'package:dashboard_bloc/app/controller/menu_controller.dart';
import 'package:dashboard_bloc/app/controller/token_controller.dart';
import 'package:dashboard_bloc/app/presentation/widget/error_message.dart';
import 'package:dashboard_bloc/app/utils/api_endpoints.dart';
import 'package:dashboard_bloc/app/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

    final MenunController menuController = Get.find<MenunController>();
    TokenAdminController tokenController = Get.find<TokenAdminController>();

class DataMesaController extends GetxController {


    // Future<void> getData() async {
    //     tokenController.tokenName();
    //     var headers = {
    //         'Content-Type': 'application/json',
    //         'Authorization': tokenController.token.value
    //     };
    //     //print('token mil : ${tokenController.token.value}');
    //     try {  
    //         var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.adminMesa);
    //         http.Response response = await http.get(url, headers: headers);
    //         if (response.statusCode == 200) {
    //              final Map<String, dynamic> responseData = jsonDecode(response.body);
    //             ModelMesa modelMesa = ModelMesa.fromJson(responseData);
    //             return modelMesa;
    //         }
    //         update();
    //     } catch (e){
    //         throw 'error';
    //     }
        
    // }

    Future<void> postData(String urlCode, String nombre, bool isActive) async {
        tokenController.tokenName();
         print('Url mesa: $urlCode');
        print('mesa:  $nombre');
        print(isActive);
        var headers = {
            'Content-Type': 'application/json',
            'Authorization': tokenController.token.value
        };
        //print('token mil : ${tokenController.token.value}');
        try {  
            var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.adminMesa);
            Map<String, dynamic> requestData = {
                'url': urlCode,
                'nombre': nombre,
                'activo': isActive
            };
            print('no llego');
            http.Response response = await http.post(url, body: jsonEncode(requestData), headers: headers);
            if(response.statusCode == 201 || response.statusCode == 200 ){
                final responseData = jsonDecode(response.body);
                final message = responseData['messages'];
                if (message != null && message is List && message.isNotEmpty){
                    final messages = message[0];
                    if (messages['code'] == 'record_created'){
                        Message.taskErrororWarning('Mesa', 'se guardo correctamente la categoria $nombre');
                        menuController.selectedMenu('');
                        menuController.selectedMenu('Mesa');
                    }
                    
                }
                //print('Registro creado con éxito');
            
            } else {
                //print('Error al agregar datos. Código de respuesta: ${response.statusCode}');
                throw 'Error de conexion';
                
            }
            update();
        } catch (e) {
            //print('error: $e');
            Get.back();
            showDialog(
                context: Get.context!, 
                builder: (context){
                    return SimpleDialog(
                        title: const Text('Error'),
                        contentPadding: const EdgeInsets.all(20),
                        children: [Text('Hubo un error al agregar datos : $e')],
                    );
                }
            );
        }

    }

    Future<void> deleteData(String id) async {
        tokenController.tokenName();
        var headers = {
            'Content-Type': 'application/json',
            'Authorization': tokenController.token.value
        };
        var url = Uri.parse('${ApiEndPoints.baseUrl}${ApiEndPoints.authEndpoints.adminMesa}/$id');
        Get.dialog(
            AlertDialog(
                title:  Text(menuController.token.value),
                content: const Text('¿Estas seguro de que deseas eliminar este registro?'),
                actions: [
                    TextButton(
                        onPressed: () async {
                            http.Response response = await http.delete(url, headers: headers);
                            if ( response.statusCode == 200) {
                                Navigator.of(Get.overlayContext!).pop();
                                print(menuController.token.value);
                                menuController.selectedMenu('');
                                menuController.selectedMenu('Mesa');
                            }
                            Get.snackbar(
                                'Eliminar',
                                'Se elimino el registro',
                                backgroundColor: AppColor.blue,
                                colorText: AppColor.blueLight
                            );
                            // if (response.body.isNotEmpty) {

                            // }
                        }, 
                        child: const Text('Aceptar'),
                    ),

                    TextButton(
                        onPressed: () {
                            Get.snackbar(
                                'Error al Eliminar',
                                'Hubo un problema al intentar eliminar el registro',
                                backgroundColor: AppColor.blue,
                                colorText: AppColor.blueLight
                            );
                            Navigator.of(Get.overlayContext!).pop();
                        }, 
                        child:  const Text('Cancelar')
                    )
                ],
            )
        ); 
    } 

    Future<void> updateMesa(String id, String url, String nombre, bool activo) async {
        tokenController.tokenName();
        var headers = {
            'Content-Type': 'application/json',
            'Authorization': tokenController.token.value,
        };

        try {
            var apiUrl = Uri.parse('${ApiEndPoints.baseUrl}${ApiEndPoints.authEndpoints.adminMesa}/$id');
            Map<String, dynamic> dataMesaUpdate = {
                'id': id,
                'url': url,  // Usa url.toString() aquí
                'nombre': nombre,
                'activo': activo,
            };

            http.Response response = await http.put(apiUrl, headers: headers, body: jsonEncode(dataMesaUpdate));
    
            if (response.statusCode == 200) {
                menuController.selectedMenu('');
                menuController.selectedMenu('Mesa');
            } else {
                throw 'Error en la solicitud, código de estado ${response.statusCode}';
            }
        } catch (e) {
            throw 'Error de conexión UpdateMesaSalida $e';
        }
    }




}