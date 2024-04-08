import 'package:dashboard_bloc/app/controller/categoria_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriaWidget extends StatelessWidget {
    CategoriaWidget({Key? key}) : super(key: key);

    final CategoriaController controller = Get.find<CategoriaController>();

    @override
    Widget build(BuildContext context) {
        return Column(
        children: [
            SizedBox(
                height: 550, // Ajusta la altura según sea necesario
                child: Obx(
                    () => ListView(
                        children: controller.cardListCategory,
                    ),
                ),
            ),
            
            // Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //         ElevatedButton(
            //             onPressed: () {
            //                 if (controller.paginaActual > 1) {
            //                     controller.paginaActual--;
            //                     controller.cargarPagina(controller.paginaActual.value);
            //                 }
            //             },
                        
            //             child: const Text('Anterior'),
            //         ),
                    
            //         const SizedBox(width: 20),
            //         ElevatedButton(
            //             onPressed: () {
            //                 print('hola s');
            //                 final int elementosPorPagina = controller.elementosPorPagina;
            //                 final num startIndex = (controller.paginaActual - 1) * elementosPorPagina;
            //                 final num endIndex = startIndex + elementosPorPagina - 1;
            //                 print('$startIndex');
            //                 print('$endIndex');

            //                 if (endIndex < controller.cardListCompleta.length - 1) {
            //                     controller.paginaActual++;
            //                     controller.cargarPagina(controller.paginaActual.value);
            //                 }
            //             },
                        
            //             child: const Text('Siguiente'),
            //         ),
            //     ],
            // ),
        ],
        );
    }
}
