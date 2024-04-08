import 'dart:async';
import 'dart:convert';

import 'package:dashboard_bloc/app/controller/data_categoria_controller.dart';
import 'package:dashboard_bloc/app/controller/token_controller.dart';
import 'package:dashboard_bloc/app/presentation/widget/error_message.dart';
import 'package:dashboard_bloc/app/utils/api_endpoints.dart';
import 'package:dashboard_bloc/app/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

    TokenAdminController tokenController = Get.find<TokenAdminController>();

class DataSubCategoriaController extends GetxController {
    Future<void> postData(String idCategoria, String nombre, String description, bool activo, double precio, double calorias, String tiempo) async {
        tokenController.tokenName();
        var headers = {
            'Content-Type': 'application/json',
            'Authorization': tokenController.token.value
        };

        try {
            var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.adminProductos);
            Map<String, dynamic> requestData = {
                'idCategoria': idCategoria,
                'nombre': nombre,
                'descripcion': description,
                'precio': precio,
                'activo': activo,
                'tiempo': tiempo,
                'calorias': calorias
            };

            http.Response response = await http.post(url, body: jsonEncode(requestData), headers: headers);
            if (response.statusCode == 201) {
                final responseData = jsonDecode(response.body);
                final message = responseData['messages'];
                menunController.selectedMenu('');
                menunController.selectedMenu('Producto');
                if (message != null && message is List && message.isNotEmpty) {
                    final messages = message[0];
                    if (messages['code'] == 'record_create') {
                        Message.taskErrororWarning('delivery', 'Se guardo correctamente el producto');
                    }
                }
                print('registro creado con exito');
            } else {
                print('error al agregar datos, codigo de respuesta ${response.statusCode}');
                print('response body ${response.body}');
                throw 'error de conexion';
            }
        } catch (error) {
            print('error1 $error');
            throw 'error de conexion';
        }
    }

    Future<void> deleteData(String id) async {
        tokenController.tokenName();
        var headers = {
            'Content-Type': 'application/json',
            'Authorization': tokenController.token.value
        };

        var url = Uri.parse('${ApiEndPoints.baseUrl}${ApiEndPoints.authEndpoints.adminProductos}/$id');
        Get.dialog(
            AlertDialog(
                title: const Text('Eliminar Registro'),
                content: const Text('¿Estas seguro de que deseas eliminar este registro?'),
                actions: [
                    TextButton(
                        onPressed: () async{
                            http.Response response = await http.delete(url, headers: headers);
                            if ( response.statusCode == 200) {
                                Navigator.of(Get.overlayContext!).pop();
                                menunController.selectedMenu('');
                                menunController.selectedMenu('Producto');
                            }
                        }, 
                        child: const Text('Aceptar')
                    ),

                    TextButton(
                        onPressed: () async{
                            Get.snackbar(
                                'Error al eliminar', 
                                'Hubo un problema al intentar eliminar el registro',
                                backgroundColor: AppColor.blueDark,
                                colorText: AppColor.white
                            );
                            Navigator.of(Get.overlayContext!).pop();
                        },
                        child: const Text('Cancelar')
                    )
                ],
            )
        );

    }

    Future<void> updateNoImagen(String id, String nombre, String description, bool activo, double precio, String tiempo, double calorias) async{
        tokenController.tokenName();
        var headers = {
            'Content-Type': 'application/json',
            'Authorization': tokenController.token.value
        };

        try {
            var url = Uri.parse('${ApiEndPoints.baseUrl}${ApiEndPoints.authEndpoints.adminProductosImage}/$id');
            print(url);
            Map<String, dynamic> dataToUpdate = {
                'id': id,
                'nombre': nombre,
                'descripcion': description,
                'activo': activo,
                'precio': precio,
                'time': tiempo,
                'calorias': calorias
            };

            http.Response response = await http.put(url, headers: headers, body: jsonEncode(dataToUpdate));
            if (response.statusCode == 200) {
                // ignore: unused_local_variable
                final responseData = jsonDecode(response.body);
                menunController.selectedMenu('');
                menunController.selectedMenu('Producto');
            } else {
                throw 'Error en la solicitud. codigo de etado: ${response.statusCode}';
            }
            
        } catch (e) {
            throw 'Error de conexion UpdateNoImagen $e';
        }

    }

    Future<void> updateImagen(String id, String imagen) async {
        tokenController.tokenName();
        var headers ={
            'Content-Type': 'application/json',
            'Ahthorization': tokenController.token.value
        }; 

        try {
            var url = Uri.parse('${ApiEndPoints.baseUrl}${ApiEndPoints.authEndpoints.adminProductos}/$id');
            print(url);
            Map<String, dynamic> dataImagen = {
                'id': id,
                'imagen': imagen
            };

            http.Response response = await http.put(url, headers: headers, body: dataImagen);
            if ( response.statusCode == 200 ) {
                // ignore: unused_local_variable
                final responseData = jsonDecode(response.body);
                menunController.selectedMenu('');
                menunController.selectedMenu('Producto');
            } else {
                throw 'error en la solicitud, UpdateImagen: ${response.statusCode}';
            }
        } catch (e) {
            throw 'Error en la solicitud UpdateImagen:  $e';
        }

    }

}
