
import 'package:dashboard_bloc/app/controller/data_mesa_controller.dart';
import 'package:dashboard_bloc/app/controller/menu_controller.dart';
import 'package:dashboard_bloc/app/data/model/model_mesa/mmesa_data.dart';
import 'package:dashboard_bloc/app/data/model/model_mesa/model_mesa.dart';
import 'package:dashboard_bloc/app/data/repository/mesa_repository.dart';
import 'package:dashboard_bloc/app/presentation/categoria/widget/dropdown_item.dart';
import 'package:dashboard_bloc/app/presentation/categoria/widget/dropdown_widget_edit.dart';
import 'package:dashboard_bloc/app/presentation/categoria/widget/text_field.dart';
import 'package:dashboard_bloc/app/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MesaController extends GetxController {
    MesaRepository mesaRepository = MesaRepository();
    MenunController menunController = Get.find<MenunController>();
    RxList<Widget> cardListMesa = <Widget>[].obs;
    

    

    Future<void> callGetDataModelMesa() async {
        print('llamando al callgetdatamodelmesa');
        await  getDataModelMesa();
    }
    

      //-------------------EDITAR----------------------//

    final List<ItemDropdown> listStatus = [
        ItemDropdown(label: 'Activo', value: 'Activo'),
        ItemDropdown(label: 'Inactivo', value: 'Inactivo'),
    ];

    ItemDropdown? selectStatus;
    bool isActivo = false;
    final TextEditingController idMesa = TextEditingController();
    final TextEditingController urlMesa = TextEditingController();
    final TextEditingController nombreMesa = TextEditingController();
    final ValueNotifier<bool> activoMesa = ValueNotifier<bool>(false);

    void showFormDialogEdit(BuildContext context, MesaData modelMesaData) {

        idMesa.text = modelMesaData.id!;
        urlMesa.text = modelMesaData.url;
        nombreMesa.text = modelMesaData.nombre;
        activoMesa.value = modelMesaData.activo;

        showDialog(
        context: context,
        builder: (builderContext) => _buildDialog(builderContext),
        );
    }
    //-------------------------------------------------//
     Widget _buildDialog(BuildContext context) {
        return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: AppColor.bgSideMenu,
            child: Container(
                padding: const EdgeInsets.all(10),
                width: 400,
                height: 500,
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                    IconButton(
                                        onPressed: () {
                                            Navigator.of(context).pop();
                                        },
                                        icon: Icon(Icons.arrow_back, color: AppColor.white),
                                    ),

                                    Text('Editar Mesa', style: TextStyle(color: AppColor.yellow)),
                                    TextButton(
                                        onPressed: () async {
                                            try {
                                                DataMesaController dataMesaController = Get.find<DataMesaController>();
                                                await dataMesaController.updateMesa(idMesa.text, urlMesa.text, nombreMesa.text, activoMesa.value);
                                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                                    Navigator.of(context).pop();
                                                });    
                                            } catch (error) {
                                                print('Error al actualizar la mesa: $error');
                                                // Puedes agregar más lógica de manejo de errores aquí
                                            }
                                        },
                                        
                                        child: const Text('Actualizar', style: TextStyle(color: Colors.green)),
                                    )

                                ],
                            ),

                            const SizedBox(height: 15),
                            TextFieldWidget( label: 'Url', placeHolder: 'Url', width: 300, controller: urlMesa, error: true, onChanged: (text) {} ),
                        
                            const SizedBox(height: 15),
                            TextFieldWidget( label: 'Nombre', placeHolder: 'Nombre', width: 300, controller: nombreMesa, error: true, onChanged: (text) {} ),
            
                            const SizedBox(height: 30),
                            DropDownWidgetEdit( label: 'Estado', list: listStatus, onSelect: (select) { selectStatus = select; }, defaultValue: activoMesa.value ? 'Activo' : 'Inactivo', whidt: 300, itemWidth: 230, error: true ),
                        ],
                    ),
                ),
            ),
        );
    }

  //_______________________________________________//



    Future<void> getDataModelMesa() async {
        
        ModelMesa mesaData = await mesaRepository.getDataModelMesa();
        print('data cargada: $mesaData');
        cardListMesa.clear();

        for (var modelMesa in mesaData.data) {
        
            cardListMesa.add(
                Container( width: 100, height: 100, margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: AppColor.blue, width: 1.0),
                    ),
                    child: Column(
                        children: [
                            // Encabezado
                            Container( 
                                decoration:  BoxDecoration(
                                    color: AppColor.blue,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20.0),
                                        topRight: Radius.circular(20.0),
                                    ),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                        MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: GestureDetector(
                                                onTap: () {
                                                    
                                                },  
                                                child: ColoredBox(
                                                    color: Colors.transparent,
                                                    child: Icon(Icons.notifications, size: 20, color: AppColor.white,))
                                            ),
                                        ),

                                        const SizedBox(width: 5),
                                        GestureDetector(
                                            onTap: () {
                                                
                                            },
                                            child: Icon(Icons.message_outlined, size: 20, color: AppColor.lead,)
                                        ),
                                        const SizedBox(width: 8),
                                        Text( modelMesa.nombre, style: TextStyle( fontSize: 15, color: AppColor.green, fontWeight: FontWeight.w300 )),

                                        const SizedBox(width: 5),
                                        PopupMenuButton<int>(
                                            icon: Icon(Icons.more_vert, color: AppColor.pink,),
                                            color: AppColor.blueDark,
                                            itemBuilder: (context) => [
                                                PopupMenuItem<int>(
                                                    value: 1,
                                                    child: Row(
                                                        children: [
                                                            GestureDetector(
                                                                onTap: () {
                                                                    Navigator.pop(context);
                                                                    // ignore: unused_local_variable
                                                                    final DataMesaController dataMesaController = Get.put(DataMesaController());
                                                                    Get.find<DataMesaController>().deleteData(modelMesa.id.toString());
                                                        
                                                                },
                                                                child: Container(
                                                                padding: const EdgeInsets.all(5),
                                                                    child: Row(
                                                                        children: [
                                                                            Icon(Icons.delete, size: 16, color: AppColor.blueLight),
                                                                                
                                                                            const SizedBox(width: 5),
                                                                            Text('Eliminar', style: TextStyle(color: AppColor.blueLight)),
                                                                        ],
                                                                    ),
                                                                ),
                                                            ),
                                                            
                                                        ],
                                                    ),
                                                ),
                                            
                                                PopupMenuItem<int>(
                                                    value: 2,
                                                    child: Row(
                                                        children: [
                                                            GestureDetector(
                                                                onTap: () {
                                                                    Navigator.pop(context);
                                                                    print(modelMesa.id);
                                                                    showFormDialogEdit(context, MesaData(id: modelMesa.id, nombre: modelMesa.nombre, url: modelMesa.url, activo: modelMesa.activo));
                                                                },
                                                                child: Container(
                                                                    padding: const EdgeInsets.all(5),
                                                                    child: Row(
                                                                        children: [
                                                                            Icon(Icons.edit, size: 16, color: AppColor.blueLight),
                                                                                
                                                                            const SizedBox(width: 5),
                                                                            Text('Editar', style: TextStyle(color: AppColor.blueLight)),
                                                                        ]
                                                                    ),
                                                                ),
                                                            )
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
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(20.0),
                                        bottomRight: Radius.circular(20.0),
                                    ),
                                    child: Image.asset( 'images/menu.png', fit: BoxFit.cover, width: double.infinity, height: double.infinity ),
                                ),
                            ),  
                        ],
                    ),
                )
            );
        
        }
    }
    
}