import 'package:dashboard_bloc/app/controller/data_promocion_controller.dart';
import 'package:dashboard_bloc/app/controller/menu_controller.dart';
import 'package:dashboard_bloc/app/data/model/model_promocion/model_promocion.dart';
import 'package:dashboard_bloc/app/data/repository/promocion_repository.dart';
import 'package:dashboard_bloc/app/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PromocionController extends GetxController {
    PromocionRepository promocionRepository = PromocionRepository();
    MenunController menunController = Get.find<MenunController>();
    RxList<Widget> cardListPromocion = <Widget>[].obs;

    Future<void> callGetDataModelPromocion() async {
        await getDataModelPromocion();
    }

    Future<void> getDataModelPromocion() async {
        ModelPromocion promocionData = await promocionRepository.getDataModelPromocion();
        cardListPromocion.clear();

        for (var modelPromocion in promocionData.data) {
            cardListPromocion.add(
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColor.blue, width: 1),
                    ),
                        
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: AppColor.blueDark, // Color del contenedor de arriba
                                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                                ),

                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                        Text(modelPromocion.nombre, style: TextStyle(fontSize: 16, color: AppColor.blueLight)),
                                        PopupMenuButton<int>(
                                            icon: Icon(Icons.more_horiz, color: AppColor.orange, size: 30),
                                            color: AppColor.blueDark,
                                            itemBuilder: (context) => [
                                                PopupMenuItem(
                                                    value: 1,
                                                    child: Row(
                                                        children: [
                                                            GestureDetector(
                                                                onTap: () {
                                                                    Navigator.pop(context);
                                                                    // ignore: unused_local_variable
                                                                    final DataPromocionController dataPromocionController = Get.put(DataPromocionController());
                                                                    Get.find<DataPromocionController>().deleteData(modelPromocion.id);
                                                                },
                                                                child: Row(
                                                                    children: [
                                                                        Icon(Icons.delete, size: 16, color: AppColor.blueLight),
                                                                        
                                                                        const SizedBox(width: 5),
                                                                        Text('Eliminar', style: TextStyle(color: AppColor.blueLight)),
                                                                    ],
                                                                ),
                                                            )
                                                        ],
                                                    ),
                                                ),
                                                    
                                                PopupMenuItem(
                                                    value: 2,
                                                    child: Row(
                                                        children: [
                                                            GestureDetector(
                                                                onTap: () {},
                                                                child: Row(
                                                                    children: [
                                                                        Icon(Icons.edit, size: 16, color: AppColor.blueLight),
                                                                        
                                                                        const SizedBox(width: 5),
                                                                        Text('Editar', style: TextStyle(color: AppColor.blueLight)),
                                                                    ],
                                                                ),
                                                            )
                                                        ],
                                                    ),
                                                )
                                            ],
                                        )
                                    ],
                                ),
                            ),
                                
                            Expanded(
                                flex: 2,
                                child: InkWell(
                                    onTap: () {
                                        print('imagen cambiar');
                                    },
                                    child: const Text('hola')//Image.asset(modelPromocion.image!, fit: BoxFit.cover)
                                ),
                            ),
                            
                            Container(
                                decoration: BoxDecoration(
                                    color: AppColor.blue, // Color del contenedor de abajo
                                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                ),
                                    
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                            Text('${modelPromocion.precio.toString()} €', style: TextStyle(fontSize: 18, color: AppColor.orange)),
                                            Row(
                                                children: [
                                                    GestureDetector(
                                                        onTap: () {},
                                                        child: Row(
                                                            children: [
                                                                Icon(Icons.toggle_off, size: 40, color: AppColor.blueLight),
                                                            ],
                                                        ),
                                                    ),
                                                ],
                                            ),
                                        ],
                                    ),
                                ),
                            ),
                        ],
                    ),
                ),
            );
        }
    }
}
