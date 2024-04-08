import 'package:dashboard_bloc/app/controller/categoria_controller.dart';
import 'package:dashboard_bloc/app/controller/menu_controller.dart';
import 'package:dashboard_bloc/app/controller/mesa_controller.dart';
import 'package:dashboard_bloc/app/controller/promocion_controller.dart';
import 'package:dashboard_bloc/app/controller/sub_categoria_controller.dart';
import 'package:dashboard_bloc/app/presentation/dashboard/side_bar.dart';
import 'package:dashboard_bloc/app/presentation/dashboard/top_bar.dart';
import 'package:dashboard_bloc/app/presentation/categoria/widget/categoria_widget.dart';
import 'package:dashboard_bloc/app/presentation/dashboard/widget/notificacion_admin.dart';
import 'package:dashboard_bloc/app/presentation/mesas/mesa_widget.dart';
import 'package:dashboard_bloc/app/presentation/promocion/promocion_widget.dart';
import 'package:dashboard_bloc/app/presentation/sub_categorias/widget/sub_categoria_widget.dart';
import 'package:dashboard_bloc/app/presentation/ui/usuario/usuario.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dashboard extends StatefulWidget {
    static String routeName = 'dashboard';
    final Widget child;

    const Dashboard({Key? key, required this.child}) : super(key: key);

    @override
    State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with SingleTickerProviderStateMixin {
    static final GlobalKey<_DashboardState> dashboardKey = GlobalKey<_DashboardState>();

    final MenunController menunController = Get.find<MenunController>();
    late CategoriaController categoriaController;
    late SubCategoriaController subCategoriaController;
    late MesaController mesaController;
    late PromocionController promocionController;

    @override
    void initState() {
        super.initState();
        categoriaController = Get.put(CategoriaController());
        subCategoriaController = Get.put(SubCategoriaController());
        mesaController = Get.put(MesaController());
        promocionController = Get.put(PromocionController());
    }

    @override
    Widget build(BuildContext context) {
        final size = MediaQuery.of(context).size;

        return Scaffold(
            body: Stack(
                children: [
                    Row(
                        children: [
                            if (size.width >= 700) const SideBar(),
                            Expanded(
                                child: Column(
                                    children: [
                                        
                                        const TopBar(),
                                        const SizedBox(height: 10),
                                        const Padding(
                                            padding: EdgeInsets.all(20.0),
                                            child:  NotificationAdmin(),
                                        ),
                                        Expanded(
                                            child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                                child: Obx(() {
                                                    if (menunController.selectedMenu.value == 'Producto') {
                                                        //print('primero  :${subCategoriaController.idCategoriaRx.value}');

                                                        subCategoriaController.getIdCategoria(idCategoria: subCategoriaController.idCategoriaRx.value);
                                                        return SubCategoriaWidget();
                                                    
                                                    } else if (menunController.selectedMenu.value == 'Categoria') {
                                                        menunController.selectedProducto.value == 'Producto';
                                                        categoriaController.callGetDataModelCategoria();
                                                        return CategoriaWidget();
                                                    
                                                    } else if (menunController.selectedMenu.value == 'Mesa') {
                                                        mesaController.callGetDataModelMesa();
                                                        return MesaWidget(key: dashboardKey,);

                                                    } else if (menunController.selectedMenu.value == 'Promocion') {
                                                        promocionController.getDataModelPromocion();
                                                        return PromocionWidget();

                                                    } else if (menunController.selectedMenu.value == 'Usuario') {
                                                        
                                                        return const  UsuarioUpdate();

                                                    

                                                    } else {
                                                        return widget.child;
                                                    }
                                                }),
                                            ),
                                        ),
                                        
                                
                                    ],
                                ),
                            ),
                        ],
                    ),
                ],
            ),
        );
    }
}
