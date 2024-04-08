import 'package:dashboard_bloc/app/controller/menu_controller.dart';
import 'package:dashboard_bloc/app/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';



class SideBar extends StatefulWidget {
    const SideBar({super.key});

    @override
    State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
    int selectedIndex = -1;
    
    int hoverIndex = -1;

    String itemm = '';
        
    final MenunController menuController = Get.find<MenunController>();
    List<DashboardItem> dashboardItems = [
        DashboardItem(title: 'Dashboard', icon: Icons.dashboard),
        DashboardItem(title: 'Mesa', icon: Icons.table_bar_sharp),
        DashboardItem(title: 'Promocion', icon: Icons.hive),
        DashboardItem(title: 'Categoria', icon: Icons.layers_rounded),
        DashboardItem(title: 'Usuarios', icon: Icons.person)
    ];

    @override
    Widget build(BuildContext context) {
        return Material(
            child: Padding(
                
                padding: const EdgeInsets.all(10),
                child: Row(
                    children: [
                    // Menú de la izquierda
                        Container(
                        
                            width: 250,
                            decoration: BoxDecoration(
                                color: AppColor.bgSideMenu, // Fondo azul oscuro
                                borderRadius: BorderRadius.circular(20), // Bordes redondeados
                            ),
                            padding: const EdgeInsets.all(2), // Padding de 20
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Row(
                                        children: [
                                            
                                            ClipRRect(
                                                borderRadius: BorderRadius.circular(20),
                                                child: Container(
                                                    padding: EdgeInsets.all(10),
                                                    width: 100,
                                                    height:100,
                                                    child: Image.asset('assets/images/logo.png', fit: BoxFit.cover,)
                                                )
                                            ), 
                                            const SizedBox(width: 15,),
                                            Center(
                                                child: Column(
                                                    children: [
                                                        const SizedBox(height: 10),
                                                        Text('DRINK &', style: TextStyle(color: AppColor.orange, fontSize: 24)),
                                                        Text('TRINK', style: TextStyle(color: AppColor.orange, fontSize: 24)),
                                                    ],
                                                ),
                                            ),
                                        ],
                                    ),
                            
                                    const Divider(color: Colors.white),
                                    const SizedBox(height: 30),
    
                                    Expanded(
                                        child: ListView.builder(
                                            itemCount: dashboardItems.length,
                                            itemBuilder: (context, index) {
                                                final item = dashboardItems[index];
                                                return MouseRegion(
                                                    onEnter: (_) {
                                                        setState(() {
                                                            hoverIndex = index; // Cambia el color al pasar el cursor
                                                        });
                                                    },
                                                    onExit: (_) {
                                                        setState(() {
                                                            hoverIndex = -1; // Volver al color predeterminado
                                                        });
                                                    },

                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                            color: selectedIndex == index
                                                            ? AppColor.bggsideMenu// Elemento seleccionado en verde
                                                            : hoverIndex == index
                                                            ? AppColor.sideMenu// Cambia de color al pasar el cursor a naranja
                                                            : AppColor.bgSideMenu, // Color predeterminado
                                                            borderRadius: BorderRadius.circular(10),
                                                        ),

                                                        child: ListTile(
                                                            
                                                            title: Text(item.title, style: TextStyle(color: selectedIndex == index ? AppColor.orange : AppColor.lead)),
                                                            leading: Icon(item.icon, color: selectedIndex == index ? AppColor.orange : AppColor.lead),
                                                            onTap: () {
                                                                setState(() {
                                                                    selectedIndex = index; // Cambia el color al hacer clic
                                                                    print('Elemento : ${item.title}');
                                                                });

                                                                if (item.title == 'Mesa'){ 
                                                                    itemm = item.title;
                                                                    print('Elemento seleccionado: ${item.title}');
                                                                    menuController.selectedMenu.value = 'Mesa';
                                                                } 
                                                                if (item.title == 'Categoria'){ 
                                                                    menuController.selectedMenu.value = 'Categoria'; 
                                                                    menuController.selectedProducto.value = 'Producto';
                                                                }
                                                                if (item.title == 'Promocion') {
                                                                    menuController.selectedMenu.value = 'Promocion';
                                                                    print(menuController.selectedMenu.value);
                                                                }
                                                                if (item.title == 'Usuarios') {
                                                                    menuController.selectedMenu.value = 'Usuarios';
                                                                }
                                                            },
                                                        ),
                                                    ),
                                                );
                                            },
                                        ),
                                    ),
    
                                    const Divider(color: Colors.white),
                                    Container(
                                        decoration: BoxDecoration(
                                            color: selectedIndex == dashboardItems.length
                                            ? Colors.green
                                            : hoverIndex == dashboardItems.length
                                            ? const Color.fromARGB(255, 213, 109, 23)
                                            : AppColor.bgSideMenu,
                                            borderRadius: BorderRadius.circular(20),
                                        ),
    
                                        child: ListTile(
                                            title: const Text('Configuration', style:  TextStyle(color: Colors.white)),
                                            leading: const Icon(Icons.get_app_rounded, color: Colors.white),
                                            onTap: () {
                                                setState(() {
                                                    selectedIndex = dashboardItems.length; // Cambia el color al hacer clic
                                                });
                                                print('Elemento seleccionado: Nuevo3');
                                            },
                                        ),
                                    ),

                                    Container(
                                        decoration: BoxDecoration(
                                            color: selectedIndex == dashboardItems.length + 1
                                            ? Colors.green
                                            : hoverIndex == dashboardItems.length + 1
                                            ? const Color.fromARGB(255, 213, 109, 23)
                                            : AppColor.bgSideMenu,
                                            borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: ListTile(
                                            title: const Text('Salir', style:  TextStyle(color: Colors.white)),
                                            leading: const Icon(Icons.exit_to_app, color: Colors.white),
                                            onTap: () {
                                                setState(() {
                                                    selectedIndex = dashboardItems.length + 1; // Cambia el color al hacer clic
                                                });
                                                print('Elemento seleccionado: Nuevo4');
                                            },
                                        ),
                                    ),
                                ],
                            ),
                        ),
                    ],
                ),
            ),
        );
    }
}

class DashboardItem {
    final String title;
    final IconData icon;

    DashboardItem({required this.title, required this.icon});
}