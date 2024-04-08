
part of './pages.dart';
abstract class Routes{

    static const initial = '/login';
    static const dashboard = '/dashboard';
    static const login = '/login';
    static const subCategory = '/subCategoria';
    static const categoria = '/categoria';
    static const mesa = '/mesa';

    static String categoriaWidget() => categoria;
    static String mesaWidget()      => mesa;
//     static String getDashboard   ()     => dashboard;
}