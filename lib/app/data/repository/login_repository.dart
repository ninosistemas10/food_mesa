

// import 'dart:convert';

// import 'package:dashboard_bloc/app/routes/pages.dart';
// import 'package:dashboard_bloc/app/utils/api_endpoints.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:dashboard_bloc/app/data/model/model_user/model_users.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LoginRepository {
//     final _prefs = SharedPreferences.getInstance();
//     Future<ModelUsers> login({required String email, required String password}) async {
//         final url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.loginEmail); // Reemplaza con la URL de tu API
//         final body = jsonEncode({
//             'email': email,
//             'password': password,
//         });
//         final headers = {'Content-Type': 'application/json'};

//         final response = await http.post(url, body: body, headers: headers);

//         if (response.statusCode == 200) {
//             final Map<String, dynamic> json = jsonDecode(response.body);
//             final ModelUsers modelUsers = ModelUsers.fromJson(json);

//             var token = modelUsers.data.token;
//             var user = modelUsers.data.user;

//         // Puedes usar 'token' y 'user' en tu aplicación
//             print('Token: $token');
//             print('User ID: ${user.id}');
//             print('User Email: ${user.email}');
//             print('User Nombre: ${user.isAdmin}');

//             final SharedPreferences prefs = await _prefs;
//             await prefs.setString('token', token);

    
//             Get.offAllNamed(Routes.dashboard);
//         } else {
//             throw 'Error en la respuesta JSON';
//         }
    
//         throw 'Error al autenticar al usuario: ${response.statusCode}';
//     }
// }

