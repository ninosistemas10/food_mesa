



import 'package:dashboard_bloc/app/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';
import 'package:get_storage/get_storage.dart';

class AuthMiddleware extends GetMiddleware {
    @override
    RouteSettings? redirect(String? route) {
    //VALIDACION SI TIENE PERMISO PARA ENTRAR
        final box = GetStorage();

        bool isLogged = box.read('isLogged') ?? false;

        if (route != Routes.login) {
            return isLogged ? null : const RouteSettings(name: Routes.login);
        } else {
            return isLogged ? const  RouteSettings(name: Routes.dashboard) : null;
        }
    }
}
