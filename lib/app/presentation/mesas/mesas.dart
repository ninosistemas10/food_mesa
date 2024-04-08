// ignore_for_file: must_be_immutable

import 'package:dashboard_bloc/app/data/repository/mesa_repository.dart';
import 'package:dashboard_bloc/app/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';


class Mesas extends StatelessWidget {
    Mesas({super.key});


    MesaRepository mesaRepository = MesaRepository();


    @override
    Widget build(BuildContext context) {
        double screenWidth = MediaQuery.of(context).size.width;
        
        return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
            itemBuilder: (_, index) {
                if (index == 8) {
                    // Último elemento (botón para agregar mesa)
                    return GestureDetector(
                        onTap: () {
                            // Agregar lógica para agregar una mesa al hacer clic
                            print('Agregar mesa');
                        },
                        child: Container(
                            width: 100,
                            height: 100,
                            margin: const EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: const Icon(Icons.add, size: 30, color: Colors.blue),
                        ),
                    );
                } else {
                    // Elementos regulares
                    return Container(
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(color: Colors.black, width: 1.0),
                        ),
                        child: Column(
                            children: [
                                // Encabezado
                                Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.black45,
                                        borderRadius: BorderRadius.only( topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                                    ),
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(   
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                            const Icon(Icons.notifications, size: 16),
                                            const SizedBox(width: 8),
                                            Text('Mesa ${index + 1}', style: TextStyle(fontSize: 12, color: AppColor.yellow, fontWeight: FontWeight.w300)),
                                            const SizedBox(width: 8),
                                            PopupMenuButton<int>(
                                                itemBuilder: (context) => [
                                                    const PopupMenuItem<int>(
                                                        value: 1,
                                                        child: Row(
                                                            children: [
                                                                Icon(Icons.message, size: 16),
                                                                SizedBox(width: 8),
                                                                Text('Mensaje'),
                                                            ],
                                                        ),
                                                    ),
                                                    PopupMenuItem<int>( 
                                                        value: 2,
                                                        child: Row(
                                                            children: [
                                                                const Icon(Icons.shopping_cart, size: 16),
                                                                const SizedBox(width: 8),
                                                                Text('Pedido', style: TextStyle(color: AppColor.bgSideMenu),),
                                                            ],
                                                        ),
                                                    ),
                                                ],
                                            ),
                                        ],
                                    ),
                                ),
                                // Contenido de la mesa (imagen)
                                Expanded(
                                    child: ClipRRect(
                                        borderRadius: const BorderRadius.only( bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0)),
                                        child:  Image.asset('images/menu.png',
                                            fit: BoxFit.cover,
                                            width: screenWidth,
                                            height: double.infinity,
                                        ),
                                    ),
                                ),
                            ],
                        ),
                    );
                }
            },
            itemCount: 9,
        );
    }
}
