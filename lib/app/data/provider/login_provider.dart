// import 'dart:convert';

// import 'package:dashboard_bloc/app/controller/login_controller.dart';
// import 'package:dashboard_bloc/app/utils/api_endpoints.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;



// class LoginProvider extends GetConnect {
//     LoginController loginController = LoginController();

//   Future<Response> postDataUser(
//       {required String email, required String password}) async {
//     final data = {
//       'email': loginController.emailCntrll,
//       'password': loginController.passwordCntrll
//     };
//     // var headers = {'Content-Type': 'application/json'};
//     // var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.loginEmail);

//     // try {
//     //   http.Response response = await http.post(url, body: jsonEncode(data), headers: headers);

//     //   if (response.statusCode == 200) {
//     //     print('Respuesta exitosa: ${response.body}');
//     //     return Response (statusCode: 200, headers: headers);
//     //   } else {
//     //     final errorResponse = json.decode(response.body);
//     //     final errorMessage = errorResponse['message'] ?? 'Error desconocido';

//     //     print('Error en la solicitud: $errorMessage');
//     //     throw errorMessage;
//     //   }
//     // } catch (e) {
//     //   print('Problemas de conexión: $e');
//     //   throw 'Problemas de conexión';
//     // }
//   }
// }
