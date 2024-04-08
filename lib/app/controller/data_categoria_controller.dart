

import 'dart:convert';


import 'package:dashboard_bloc/app/controller/menu_controller.dart';
import 'package:dashboard_bloc/app/controller/token_controller.dart';
import 'package:dashboard_bloc/app/data/model/model_categoria/category_data.dart';
import 'package:dashboard_bloc/app/presentation/widget/error_message.dart';
import 'package:dashboard_bloc/app/utils/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

    final MenunController menuController = Get.find<MenunController>();
    TokenAdminController tokenController = Get.find<TokenAdminController>();
    final MenunController menunController = Get.find<MenunController>();
class DataCategoriaController extends GetxController {

    
    
    //Crea un nuevo registro de la categoria
    Future<void> postData(String name, String description, bool isActive) async {
        tokenController.tokenName();
        var headers = {
            'Content-Type': 'application/json',
            'Authorization': tokenController.token.value
        };
        
        try {
            var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.publicCategory);
            Map<String, dynamic> requestData = {
                'nombre': name,
                'description': description,
                'activo': isActive
            };
            
            http.Response response = await http.post(url, body: jsonEncode(requestData), headers: headers);
            if (response.statusCode == 201) {
                final responseData =jsonDecode(response.body);
                final message = responseData['messages'];
                if(message != null && message is List && message.isNotEmpty ){
                    final messages = message[0];
                    if (messages['code'] == 'record_created'){
                        Message.taskErrororWarning('Delivery', 'Se guardo correctamente la categoria $name');
                        menunController.selectedMenu('');
                        menunController.selectedMenu('Categoria');
                    }
                }
                print('Registro creado con éxito');
            
            } else {
                // Error al agregar datos
                print('Error al agregar datos. Código de respuesta: ${response.statusCode}');
                print('Response Body: ${response.body}');
                throw 'Error de conexión';
            }

            update();
        } catch (error) {
            Get.back();
            showDialog(
                context: Get.context!,
                builder: (context) {
                    return SimpleDialog(
                        title: const Text('Error'),
                        contentPadding: const EdgeInsets.all(20),
                        children: [Text('Hubo un error al agregar datos: $error')],
                    );
                },
            );
        }
    }

    Future<void> deleteData( String id) async {
        tokenController.tokenName();
        var headers = {
            'Content-Type': 'application/json',
            'Authorization': tokenController.token.value
        };
    
        var url = Uri.parse('${ApiEndPoints.baseUrl}${ApiEndPoints.authEndpoints.adminCategory}/$id');
        Get.dialog(
            AlertDialog(
                title: const Text('Eliminar Registro'),
                content: const Text('¿Estás seguro de que deseas eliminar este registro?'),
                actions: [
                    TextButton(
                        onPressed: () async{
                            http.Response response = await http.delete(url, headers: headers);
                            if (response.statusCode == 200) {
                                Navigator.of(Get.overlayContext!).pop();
                                menunController.selectedMenu('');
                                menunController.selectedMenu('Categoria');
                            }
                        },
                        child: const Text('Aceptar'),
                    ),
            
                    TextButton(
                        onPressed: () async {
                            // Realizar la eliminación aquí
                            Get.snackbar(
                                'Error al eliminar',
                                'Hubo un problema al intentar eliminar el registro',
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                            );
                            Navigator.of(Get.overlayContext!).pop();
                        },
                        child:const Text('Cancelar'),
                    ),
                ],
            ),
        );
    }

    Future<CategoryData> getCategoryDetails(String id) async {
        tokenController.tokenName();
        var headers = {
            'Content-Type': 'application/json',
            'Authorization': tokenController.token.value
        };
        var url = Uri.parse('${ApiEndPoints.baseUrl}${ApiEndPoints.authEndpoints.adminCategory}/$id');

        final response = await http.get(url, headers: headers);
        print(url);
        print(response.body);

        try {
            if (response.statusCode == 200) {
                final responseData = jsonDecode(response.body);

                // Verificar si 'data' es un mapa
                if (responseData.containsKey('data') && responseData['data'] is Map<String, dynamic>) {
                    final data = responseData['data'] as Map<String, dynamic>;
                    final categoriaData = CategoryData(
                        id:           data['id'] as String,
                        nombre:       data['nombre'] as String,
                        description:  data['description'] as String,
                        activo:       data['activo'] as bool,
                        createdAt:    data['created_at'] as int,
                        updateAt:     data['updated_at'] as int?
                    );
                    return categoriaData;

                } else {
                    // Manejar la situación donde 'data' no es un mapa
                    throw 'Error: El campo "data" no es un mapa válido en la respuesta.';
                }
            } else {

                // Agregar un retorno o lanzamiento en caso de que el código de estado no sea 200
                throw 'Error en la solicitud. Código de estado: ${response.statusCode}';
            }
        } catch (error) {
            // Manejar errores aquí
            print('Error al obtener detalles de la categoría getCategoryDetails: $error');
            // Puedes lanzar una excepción o devolver un valor predeterminado según tu lógica.
            throw 'Error de conexión updateEntrada';
        }
    }




    Future<void> updateImage(String id, String imagePath, String nombre, String? description, bool activo) async {
        tokenController.tokenName();
        var headers = {
            'Content-Type': 'application/json',
            'Authorization': tokenController.token.value
        };

        try {
            var url = Uri.parse('${ApiEndPoints.baseUrl}${ApiEndPoints.authEndpoints.adminCategory}/$id');
            
            // Supongamos que el campo de imagen en tu backend se llama 'images'
            Map<String, dynamic> dataToUpdate = {
                'images': imagePath,
                'nombre': nombre,
                'description': description,
                'activo': activo
            };

            http.Response response = await http.put( url, headers: headers, body: jsonEncode(dataToUpdate) );

            if (response.statusCode == 200) {
                // ignore: unused_local_variable
                final responseData = jsonDecode(response.body);
                print('entro actualizar');
            
            } else {
                throw 'Error en la solicitud. Código de estado: ${response.statusCode}';
            }
        } catch (error) {
            print('Error al actualizar imagen de la categoría: $error');
            throw 'Error de conexión updateSalida';
        }
    }

    Future<void> updateNoImagen(String id, String nombre, String? description, bool activo) async {
        tokenController.tokenName();
        var headers = {
            'Content-Type': 'application/json',
            'Authorization': tokenController.token.value
        };

        try {
            var url = Uri.parse('${ApiEndPoints.baseUrl}${ApiEndPoints.authEndpoints.adminCategoryImage}/$id');
            print(id);
            print(nombre);
            print(description);
            print(activo);
            print(url);

            
            // Supongamos que el campo de imagen en tu backend se llama 'images'
            Map<String, dynamic> dataToUpdate = {
                'id': id,
                'nombre': nombre,
                'description': description,
                'activo': activo
            };

            http.Response response = await http.put( url, headers: headers, body: jsonEncode(dataToUpdate) );

            if (response.statusCode == 200) {
                // ignore: unused_local_variable
                final responseData = jsonDecode(response.body);
                print('entro actualizar');
                menunController.selectedMenu('');
                menunController.selectedMenu('Categoria');
            
            } else {
                throw 'Error en la solicitud. Código de estado: ${response.statusCode}';
            }
        } catch (error) {
            print('Error al actualizar imagen de la categoría: $error');
            throw 'Error de conexión updateNoImagenSalida';
        }
    }


    

}
