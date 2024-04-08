

import 'dart:convert';
import 'dart:typed_data';
import 'package:dashboard_bloc/app/controller/data_sub_categoria_controller.dart';
import 'package:dashboard_bloc/app/controller/menu_controller.dart';
import 'package:dashboard_bloc/app/controller/token_controller.dart';
import 'package:dashboard_bloc/app/presentation/widget/error_message.dart';
import 'package:dashboard_bloc/app/utils/api_endpoints.dart';
import 'package:dashboard_bloc/app/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

    TokenAdminController tokenAdminController = Get.find<TokenAdminController>();
    final MenunController menunController = Get.find<MenunController>();

class DataPromocionController extends GetxController {


  Future<void> postData(String nombre, String description, double precio, bool activo, Uint8List? imagen) async {
    tokenAdminController.tokenName();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': tokenAdminController.token.value
    };

    try {
      var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.adminPromocion);
      //double precio;

      var request = http.MultipartRequest('POST', url)
        ..fields.addAll({
          'nombre': nombre,
          'description': description,
          'precio': precio.toString(),
          'activo': activo.toString(),
        });

      if (imagen != null) {
        request.files.add(http.MultipartFile.fromBytes('image', imagen, filename: 'image.jpg'));
      }

      request.headers.addAll(headers);

      var response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        final message = responseData['messages'];
        if (message != null && message is List && message.isNotEmpty) {
          final messages = message[0];
          if (messages['code'] == 'record_created') {
            print('Entró de nuevo');
            Message.taskErrororWarning('Delivery', 'Se guardó correctamente la Promoción $nombre');
            menunController.selectedMenu('');
            menunController.selectedMenu('Promocion');
            Get.back();
          }
          print('Registro creado con éxito');
        }
      } else {
        throw 'Error de conexión';
      }
      update();
    } catch (error) {
      throw 'Hubo un error $error';
    }
  }

    Future<void> deleteData( String id) async {
        tokenController.tokenName();
        var headers = {
            'Content-Type': 'application/json',
            'Authorization': tokenAdminController.token.value
        };

        var url = Uri.parse('${ApiEndPoints.baseUrl}${ApiEndPoints.authEndpoints.adminPromocion}/$id');
        Get.dialog(
            AlertDialog(
                title: const Text('Eliminar Registro'),
                content: const Text('Estas seguro de que deseas eliminar este registro?'),
                actions: [
                    TextButton(
                        onPressed: () async {
                            http.Response response = await http.delete(url, headers: headers);
                            if ( response.statusCode == 200 ) {
                                Navigator.of(Get.overlayContext!).pop();
                                menunController.selectedMenu('');
                                menunController.selectedMenu('Promocion');
                            }
                            Get.snackbar(
                                'Eliminar', 
                                'Se elimino el Registro',
                                backgroundColor: AppColor.blue,
                                colorText: AppColor.blueLight
                            );
                        }, 
                        child: const Text('Aceptar')
                    ),

                    TextButton(
                        onPressed: () {
                            Get.snackbar(
                                'Error al eliminar', 
                                'hubo un problema al intentar eliminar el registro',
                                backgroundColor: AppColor.blueDark,
                                colorText: AppColor.blueLight
                            );
                            Navigator.of(Get.overlayContext!).pop();
                        }, 
                        child: const Text('Cancelar')
                    )
                ],
            )
        );
    }

} 