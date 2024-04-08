
import 'dart:typed_data';

import 'package:dashboard_bloc/app/controller/data_promocion_controller.dart';
import 'package:dashboard_bloc/app/controller/menu_controller.dart';
import 'package:dashboard_bloc/app/presentation/categoria/widget/dropdown_item.dart';
import 'package:dashboard_bloc/app/presentation/categoria/widget/dropdown_widget%20_add.dart';
import 'package:dashboard_bloc/app/presentation/categoria/widget/text_field.dart';
import 'package:dashboard_bloc/app/presentation/categoria/widget/text_price.dart';
import 'package:dashboard_bloc/app/utils/app_colors/app_colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PromocionAdd extends StatefulWidget {
    final VoidCallback onTap;
    const PromocionAdd({super.key, required this.onTap});

    @override
    State<PromocionAdd> createState() => _PromocionAddState();
}

class _PromocionAddState extends State<PromocionAdd> {

    bool isMouseOver = false;

    late MenunController menunController = Get.find<MenunController>();
    final TextEditingController nombrePromocion = TextEditingController();
    final  TextEditingController descriptionPromocion = TextEditingController(); 
    final TextEditingController precioPromocion = TextEditingController();
    ItemDropdown? selectStatus;
    bool isActivo = false;
    final List<ItemDropdown> listStatus = [
        ItemDropdown(label: 'Activo', value: 'Activo'),
        ItemDropdown(label: 'Inactivo', value: 'Inactivo')
    ];
    
    // final RxString ffilePath = ''.obs;
    // String get filePath => ffilePath.value; 
    
    Rx<Uint8List> imageByte = Uint8List(0).obs;
    Uint8List? get imageBite => imageByte.value;

    @override
    Widget build(BuildContext context) {
        return MouseRegion(
            onEnter: (_) => updateMouseOver(true),
            onExit: (_) => updateMouseOver(false),
            child: InkWell(
                onTap: () {
                    widget.onTap();
                    showAddModal(context);
                },
                child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 239, 235, 235),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: isMouseOver
                            ? const Color.fromARGB(255, 194, 47, 47)
                            : Colors.black
                        )
                    ),

                    child: const Center(
                        child: Icon(Icons.add, size: 30, color: Colors.blue),
                    ),
                ),
            ),
        );
    }

    void updateMouseOver(bool value) {
        setState(() {
            isMouseOver = value;
        });
    }

    void showAddModal (BuildContext context) {
        nombrePromocion.clear();
        descriptionPromocion.clear();
        precioPromocion.clear();
        showDialog(
            context: context, 
            builder: (BuildContext context) {
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
                                                icon: Icon(Icons.arrow_back, color: AppColor.white)
                                            ),

                                            Text('Nueva Promocion', style: TextStyle(color: AppColor.yellow)),

                                            TextButton(
                                                onPressed: ( ) {
                                                    print(imageBite);
                                                    // ignore: unused_local_variable
                                                    final DataPromocionController dataPromocionController = Get.put(DataPromocionController());
                                                    isActivo = selectStatus != null && selectStatus!.value == 'Activo';
                                                    Get.find<DataPromocionController>().postData(nombrePromocion.text, descriptionPromocion.text, double.parse(precioPromocion.text), isActivo, imageBite);
                                                    Get.back();
                                                }, 
                                                child: const Text('Grabar', style: TextStyle(color: Colors.green),)
                                            )
                                        ],
                                    ),

                                    const SizedBox(height: 15),
                                    TextFieldWidget(label: '    Nombre', placeHolder: 'Nombre', width: 320, controller: nombrePromocion, onChanged: (text) {}, error: true),

                                    const SizedBox(height: 15),
                                    TextFieldWidget(label: '    Descripcion', placeHolder: 'Descripcion', width: 320, controller: descriptionPromocion, onChanged: (text) {}, error: true),

                                    const SizedBox(height: 15),    
                                    Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Row(
                                        
                                            children: [
                                                DropDownWidgetAdd(label: '    Estado', list: listStatus, onSelect: (select) {selectStatus = select;}, whidt: 150, itemWidht: 90, error: true),

                                                const SizedBox(width: 20),
                                                TextPrice(label: '    Precio', placeHolder: '00:00', width: 150, controller: precioPromocion, onChanged: (text){}, error: true)
                                            ],  
                                        ),
                                    ),

                                    const SizedBox(height: 35),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Row(
                                    
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                        
                                                TextButton(
                                                    onPressed: () async{
                                                        FilePickerResult? resultFilePicker = await FilePicker.platform.pickFiles(
                                                            type: FileType.image,
                                                            allowMultiple: false,
                                                        );
                                                        if (resultFilePicker != null){
                                                            PlatformFile file = resultFilePicker.files.first;
                                                            //String fileName = file.name;
                                                            //String path = 'assets/image/$fileName';
                                                            imageByte.value = file.bytes!;

                                                            print(file.name);
                                                            print(file.bytes);
                                                            print(file.extension);
                                                            print(file.size);      

                                                        } else{

                                                        }
                                            
                                                    },
                                                    style: ButtonStyle(
                                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(30.0),
                                                                side: BorderSide(color: AppColor.yellow), // Borde rojo
                                                            ),
                                                        ),
                                            
                                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent)
                                                    ),
                                                            
                                                    child: Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),    
                                                        child: Text('Imagen', style: TextStyle( color: AppColor.yellow) ),
                                                    ),
                                                ),
                                    
                                                const SizedBox(width: 15),
                                                Container(
                                                    width: 200, // Ancho máximo definido
                                                    height: 40, // Altura máxima definida
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10), // Esquinas redondeadas
                                                        border: Border.all(color: AppColor.yellow), // Borde rojo
                                                    ),
                                                    
                                                    child: const  Center(
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                                Padding(
                                                                    padding: const  EdgeInsets.only(left: 10),
                                                                    //child: Obx(() =>  Text( imageByte, style: TextStyle( color: AppColor.yellow, fontSize: 15 ))),
                                                                ),
                                                            ],
                                                        ),
                                                    ),
                                                ),


                                            ],
                                    
                                        ),
                                    )


                                ],
                            ),
                        ),
                    ),
                );
            }
        );
    }

}