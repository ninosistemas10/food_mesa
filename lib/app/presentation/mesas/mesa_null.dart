import 'dart:convert';
import 'package:dashboard_bloc/app/data/model/model_mesa/model_mesa.dart';
import 'package:dashboard_bloc/app/utils/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginmmController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  Future<void> mesa() async {
  var headers = {'Content-Type': 'application/json'};
  var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.publicMesa);

  try {
    http.Response response = await http.get(url, headers: headers);
    print('URL: $url');
    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    // Verificar si la respuesta parece ser un JSON válido
    if (response.statusCode == 200 &&
        response.body.isNotEmpty &&
        (response.body.startsWith('{') || response.body.startsWith('['))) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final ModelMesa modelMesa = ModelMesa.fromJson(json);

      for (var modelM in modelMesa.data) {
        var nombre = modelM.nombre;
        print('Nombre: $nombre');
      }
    } else {
      throw 'La respuesta no parece ser un JSON válido';
    }
  } catch (error) {
    print('Error en la solicitud HTTP: $error');
    Get.back();
    showDialog(
      context: Get.context!,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Error'),
          contentPadding: const EdgeInsets.all(20),
          children: [Text('Hubo un error en la solicitud HTTP: $error')],
        );
      },
    );
  }
}

}
