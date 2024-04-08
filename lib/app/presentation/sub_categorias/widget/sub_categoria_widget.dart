import 'package:dashboard_bloc/app/controller/sub_categoria_controller.dart';
import 'package:dashboard_bloc/app/presentation/sub_categorias/sub_categorias_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubCategoriaWidget extends StatelessWidget {
  SubCategoriaWidget({Key? key}) : super(key: key);

  final SubCategoriaController controller = Get.find<SubCategoriaController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 500,
          child: Obx(() {
            if (controller.cardListSubCategoria.isEmpty) {
              return const  Column(
                children: [
                    SubCategoriaPage(),
                    Center(
                        child: Text('No hay subcategorías disponibles')),
                ],
                
              );
            } else {
              return ListView(
                children: controller.cardListSubCategoria,
              );
            }
          }),
        ),
      ],
    );
  }
}
