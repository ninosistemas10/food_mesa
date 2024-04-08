
import 'package:dashboard_bloc/app/controller/categoria_controller.dart';
import 'package:dashboard_bloc/app/controller/data_categoria_controller.dart';
import 'package:dashboard_bloc/app/controller/menu_controller.dart';
import 'package:dashboard_bloc/app/presentation/categoria/widget/dropdown_item.dart';
import 'package:dashboard_bloc/app/presentation/categoria/widget/dropdown_widget%20_add.dart';

import 'package:dashboard_bloc/app/presentation/categoria/widget/text_field.dart';

import 'package:dashboard_bloc/app/presentation/ui/login/widget/button_widget.dart';
import 'package:dashboard_bloc/app/presentation/widget/error_message.dart';
import 'package:dashboard_bloc/app/utils/app_colors/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';



// ignore: must_be_immutable
class CategoriasPage extends StatelessWidget {
    CategoriasPage({super .key});

    /*---------------------------------------------------------------------------------------
                                            GUARDAR
    *---------------------------------------------------------------------------------------- */
    final MenunController menunController = Get.find<MenunController>();
    final TextEditingController nameCategoria = TextEditingController();
    final TextEditingController descriCategoria = TextEditingController();
    //final DataController dataController = Get.put(DataController());

    bool dataValidatoion(){
        if (nameCategoria.text.trim() == '') {
            Message.taskErrororWarning('Delivery', 'Escriba el nombre');
            return false;
        } else if (descriCategoria.text.trim() == '') {
            Message.taskErrororWarning('Delivery', 'Escriba una descripcion');
            return false;
        }

        return true;
    }

    final List<ItemDropdown> listStatus = [
        ItemDropdown(label: 'Activo', value: 'Activo'),
        ItemDropdown(label: 'Inactivo', value: 'Inactivo')
    ];

    ItemDropdown? selectStatus;
    bool isActivo = false;

    @override
    Widget build(BuildContext context) {

        return Container(
            
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColor.white
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            Text('Lista de categorías', style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.black, fontSize: 25)),
                            ButtonWidget(text: 'Agregar', fColor: AppColor.yellow, tColor: AppColor.black, onPress: () { showFormDialogAdd(context, 'hola'); }),
                        ],
                    ),

                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        decoration: BoxDecoration(
                            color: AppColor.blue,
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                        ),
                        child: Column(
                            children: [
                                Row(
                                    children: [
                                        Expanded( flex: 3, 
                                            child: Text('Categoria', style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.green, fontSize: 15))
                                        ),
                            
                                        Expanded(flex: 3,
                                            child: Text('Descripcion', style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.green, fontSize: 15))
                                        ),
                            
                                        Expanded(
                                            flex: 4,
                                            child: Text('Estado', style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.green, fontSize: 15))
                                        ),
                                    ],
                                ),
                            ],

                        ),
                    ),

                    
                    
                ]
                
            )
        );
    }

    showFormDialogAdd(context, String text){
        final CategoriaController controller = Get.find<CategoriaController>();
        nameCategoria.clear();
        descriCategoria.clear();
        showDialog(
            context: context, 
            builder: (buildercontext){
                return  Dialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    backgroundColor: AppColor.bgSideMenu,
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        width: 400,
                        height: 500,
                        child:  Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                            IconButton(
                                                onPressed: (){ Navigator.of(context).pop(); }, 
                                                icon: Icon(Icons.arrow_back, color: AppColor.white),
                                            ),

                                            Text('Nueva Categoria', style: TextStyle(color: AppColor.yellow)),

                                            TextButton(
                                                onPressed: () { 
                                                    // ignore: unused_local_variable
                                                    final DataCategoriaController dataController = Get.put(DataCategoriaController());
                                                    if (dataValidatoion()) {
                                                        isActivo = selectStatus != null && selectStatus!.value == 'Activo';
                                                        Get.find<DataCategoriaController>().postData(nameCategoria.text.trim(), descriCategoria.text.trim(), isActivo);
                                                        menunController.selectedMenu('');
                                                        menunController.selectedMenu('Categoria');
                                                        ListView(
                                                            children: controller.cardListCategory,
                                                        );

                                                        Get.back();
                                                    
                                                    }
                                                }, 
                                                child: const Text('Grabar', style: TextStyle(color: Colors.green))
                                            )
                                        ],        
                                    ),

                                    const SizedBox(height: 15),
                                    TextFieldWidget(label: 'Nombre', placeHolder: 'Nombre', width: 300, controller: nameCategoria, error: true, onChanged: (text) {},),

                                    const SizedBox(height: 15),
                                    TextFieldWidget(label: 'Descripcion', placeHolder: 'Descripcion', width: 300, controller: descriCategoria, error: true, onChanged: (text) {}),
                                    
                                    const SizedBox(height: 30),
                                    DropDownWidgetAdd(label: 'Estado', list: listStatus, onSelect: (select) {selectStatus = select;}, whidt: 300, itemWidht: 230, error: true),

                                ], 
                            ),
                            
                            ),
                    ),
                );
            }
        );
    }
}