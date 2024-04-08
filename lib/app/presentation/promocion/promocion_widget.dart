
import 'package:dashboard_bloc/app/controller/promocion_controller.dart';
import 'package:dashboard_bloc/app/presentation/promocion/promocion_add.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PromocionWidget extends StatelessWidget {
    PromocionWidget({Key? key}) : super(key: key);

    final PromocionController promocionController = Get.find<PromocionController>();

    @override
    Widget build(BuildContext context) {
        return FutureBuilder(
            future: promocionController.getDataModelPromocion(), 
            builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                    return Stack(
                        children: [
                            Positioned.fill(
                                child: GridView.builder(
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4), 
                                    itemCount: promocionController.cardListPromocion.length + 1,
                                    itemBuilder: (context, index) {
                                        if ( index < promocionController.cardListPromocion.length){
                                            return Obx(() => promocionController.cardListPromocion[index]);
                                        } else {
                                            if (index == promocionController.cardListPromocion.length) {
                                                return PromocionAdd(
                                                    onTap: () {
                                                    print('agregar promocion');
                                                    },
                                                );
                                            }else {
                                                return const SizedBox();
                                            }
                                        }
                                    }
                                )
                            )
                        ],
                    );
                } else {
                    return const SizedBox();
                }
            }
        );
    }
}
