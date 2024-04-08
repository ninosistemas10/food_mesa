import 'package:dashboard_bloc/app/controller/mesa_controller.dart';
import 'package:dashboard_bloc/app/presentation/mesas/mesa_add.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MesaWidget extends StatelessWidget {
    MesaWidget({super.key});
    final MesaController mesaController = Get.find<MesaController>();

    @override
    Widget build(BuildContext context) {
        return FutureBuilder(
            future: mesaController.getDataModelMesa(), // Esperar a que getDataModelMesa se complete
            builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                    return Stack(
                        children: [
                            Positioned.fill(
                                child: GridView.builder(
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                                    itemCount: mesaController.cardListMesa.length + 1,
                                    itemBuilder: (context, index) {
                                        if (index < mesaController.cardListMesa.length) {
                                            return Obx(() => mesaController.cardListMesa[index]);
                                        } else {
                                            if (index == mesaController.cardListMesa.length) {
                                                return AddMesaWidget(
                                                    onTap: () {
                                                        print('agregar mesa');
                                                    },
                                                );
                                            } else {
                                            return const SizedBox(); // O cualquier otro widget vacío
                                            }
                                        }
                                    },
                                ),
                            ),
                        ],
                    );
                } else {
                    return const SizedBox(); // Puedes mostrar un indicador de carga mientras se espera
                }
            },
        );
    }
}
