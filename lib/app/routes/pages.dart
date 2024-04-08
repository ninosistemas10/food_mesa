
import 'package:dashboard_bloc/app/bindings/login.binding.dart';
import 'package:dashboard_bloc/app/bindings/notification_admin_binding.dart';
import 'package:dashboard_bloc/app/presentation/categoria/widget/categoria_widget.dart';


import 'package:dashboard_bloc/app/presentation/dashboard/dashboard.dart';
import 'package:dashboard_bloc/app/presentation/dashboard/inicio_dashboard/inicio_dashboard.dart';
import 'package:dashboard_bloc/app/presentation/ui/login/inicio_sesion.dart';
import 'package:get/get.dart';
part './routes.dart';



abstract class RoutesClass{

    static const dashboard = '/dashboard';
    static const login = '/login';
    static const subCategory = '/subCategoria';
    static const categoria = '/categoria';
    static const mesa = '/mesa';

    static String getAllCategoria() => categoria;
    static String getAllMesa()      => mesa;
    static String getDashboar()     => dashboard;


    static List <GetPage> routes =  [
        GetPage( name: Routes.login,         page: () => const InicioSesion(), binding: LoginBinding()),
        GetPage( name: Routes.dashboard,     page: () => const Dashboard(child: InicioDashboard()), bindings: [NotificationAdminBinding()]),
        GetPage( name: Routes.categoria,     page: () => CategoriaWidget()),
        //GetPage( name: Routes.mesa,          page: () => Dashboard(child: MesaWidget()))
    ];
}