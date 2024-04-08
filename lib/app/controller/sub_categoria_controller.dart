
import 'package:dashboard_bloc/app/controller/data_sub_categoria_controller.dart';
import 'package:dashboard_bloc/app/data/model/model_sub_categoria/sub_categoria_data.dart';
import 'package:dashboard_bloc/app/data/repository/sub_categoria_repository.dart';
import 'package:dashboard_bloc/app/presentation/categoria/widget/dropdown_item.dart';
import 'package:dashboard_bloc/app/presentation/categoria/widget/dropdown_widget_edit.dart';
import 'package:dashboard_bloc/app/presentation/categoria/widget/text_decimal.dart';
import 'package:dashboard_bloc/app/presentation/categoria/widget/text_field.dart';
import 'package:dashboard_bloc/app/presentation/categoria/widget/text_price.dart';
import 'package:dashboard_bloc/app/presentation/categoria/widget/text_tiempo.dart';
import 'package:dashboard_bloc/app/presentation/sub_categorias/sub_categorias_page.dart';
import 'package:dashboard_bloc/app/utils/app_colors/app_colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'dart:core';

import 'package:intl/intl.dart';

class SubCategoriaController extends GetxController {
    SubCategoriaRepository subCategoriaRepository = SubCategoriaRepository();
    late DataSubCategoriaController dataSController = Get.find<DataSubCategoriaController>();
    final RxList<Widget> cardListSubCategoria = <Widget>[].obs;

    final RxMap<String?, bool> isMouseOver = <String, bool>{}.obs;
    final RxMap<String?, Color> backgroundColor = <String, Color>{}.obs;


    RxString idCategoriaRx = ''.obs;
    RxString nombreCategoriaRx = ''.obs;

    //---------------------EDITAR------------------\\
    final List<ItemDropdown> listStatus = [
        ItemDropdown(label: 'Activo', value: 'Activo'),
        ItemDropdown(label: 'Inactivo', value: 'Inactivo')
    ];
    ItemDropdown? selectStatus;
    bool isActivo = false;
    final TextEditingController idSCategoria            = TextEditingController();
    final TextEditingController nombreSCategoria        = TextEditingController();
    final TextEditingController descriptionSCategoria   = TextEditingController();
    final TextEditingController precioSCategoria        = TextEditingController();
    final TextEditingController tiempoSCategoria        = TextEditingController();
    final TextEditingController caloriasSCategoria      = TextEditingController();
    final ValueNotifier<bool> activoSCategoria           = ValueNotifier<bool>(false);

    void showFormDialogEdit(SubCategoriaData modelSubCategoriaData) {
        idSCategoria.text           = modelSubCategoriaData.id!;
        nombreSCategoria.text       = modelSubCategoriaData.nombre;
        descriptionSCategoria.text  = modelSubCategoriaData.descripcion!;
        double? precio              = modelSubCategoriaData.precio;
        precioSCategoria.text       = precio.toString();
        tiempoSCategoria.text       = modelSubCategoriaData.time!;
        double? calorias            = modelSubCategoriaData.calorias;
        caloriasSCategoria.text     = calorias.toString();
        activoSCategoria.value      = modelSubCategoriaData.activo;

      
        
        showDialog(
            context: Get.context!, 
            builder: (builderContext) => buildDialog(builderContext),
        );

    }
    //---------------------------------------------\\

    buildDialog (BuildContext context) {

        return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: AppColor.sideMenu,
            child: Container(
                padding: const EdgeInsets.all(10),
                width:  400,
                height: 500,
                child: SingleChildScrollView(
                    child: Padding(
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
                
                                        Text('Editar Articulos', style: TextStyle(color: AppColor.yellow)),
            
                                        TextButton(
                                            onPressed: () async {
                                                try { 
                                                    DataSubCategoriaController dataSubCategoriaController = Get.find<DataSubCategoriaController>();
                                                    String tiempoText = tiempoSCategoria.text;//obteber la cade de tiempo
                                                    List<String> parts = tiempoText.split(':');//Dividir la cade ne partes separadas por ':'
                                                    int minutos = int.parse(parts[0]);//obtener los minutos y segundo de la lista de partes
                                                    int segundos = int.parse(parts[1]);
                                                    DateTime ahora = DateTime.now();//crear un objeto DateTime con la fecha actual y ajustar solo los minutos y segundos
                                                    DateTime  tiempo = DateTime(ahora.year, ahora.month, ahora.day, ahora.hour, minutos, segundos);
                                                    String tiempoSerializado = '${DateFormat('yyyy-MM-ddTHH:mm:ss').format(tiempo)}Z';

                                                    print('tiempo:  $tiempoSerializado');
                                                    
                                                    isActivo = selectStatus != null && selectStatus?.value == 'Activo';

                                                    await dataSubCategoriaController.updateNoImagen(idSCategoria.text, nombreSCategoria.text, descriptionSCategoria.text,
                                                    isActivo, double.parse(precioSCategoria.text), tiempoSerializado, double.parse(caloriasSCategoria.text));
                                                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                                                        Navigator.of(context).pop();
                                                    });
                                                } catch (e) {
                                                    print('error: $e');
                                                    throw 'Error al actualizar en producto $e';
                                                }

                                                
                                            }, 
                                            child: const Text('Actualizar', style: TextStyle(color: Colors.green)),
                                        )
                                    ],
                                ),                  
                            
                                const SizedBox(height: 15),
                                TextFieldWidget( label: '    Nombre', placeHolder: 'Nombre', width: 320, controller: nombreSCategoria, error: true, onChanged: (text) {} ),
                        
                                const SizedBox(height: 15),
                                TextFieldWidget( label: '    Descripcion', placeHolder: 'Descripcion', width: 320, controller: descriptionSCategoria, error: true, onChanged: (text) {} ),

                                const SizedBox(height: 15),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                        const SizedBox(height: 30),
                                        DropDownWidgetEdit( label: 'Estado', list: listStatus, onSelect: (select) { selectStatus = select; }, defaultValue: activoSCategoria.value ? 'Activo' : 'Inactivo', whidt: 150, itemWidth: 90, error: true ),

                                        const SizedBox(width: 20),
                                        TextPrice(label: '    Precio', placeHolder: '00.00', width: 150, controller: precioSCategoria, onChanged: (text) {}, error: true ),
                                    ],
                                ),

                                const SizedBox(height: 15),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                        TextTiempo(label: '    Tiempo', placeHolder: '00:00', width: 150, controller: tiempoSCategoria, onChanged: (text) {}, error: true ),

                                        const SizedBox(width: 20),
                                        TextCalorias(label: '    Calorias', placeHolder: '0.0', width: 150, controller: caloriasSCategoria, onChanged: (text) {}, error:  true)
                                    ],
                                )

                            ],
                        ),
                    ),
                ),
            ),
        );
    }


    Future<void> getDataModelSubCategoria() async {
        try {
            final subCategoriaModel = await subCategoriaRepository.getDataModelSubCategoria(idCategoria: idCategoriaRx.value);      
            List<Widget> tempWidget = [];
            cardListSubCategoria.clear();
            tempWidget.add( const SubCategoriaPage());
            tempWidget.add(
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                            for (var dataSubCategoria in subCategoriaModel!.data)
                            MouseRegion(
                                cursor: SystemMouseCursors.click,
                                onEnter: (_) {
                                    //print(dataSubCategoria.id);
                                    final String? subCategoriaId = dataSubCategoria.id;
                                    print(subCategoriaId);
                                    isMouseOver[subCategoriaId] = true;
                                    backgroundColor[subCategoriaId] = AppColor.blueDark.withOpacity(.1);
                                    update();
                                },
                                
                                onExit: (_) {
                                    final String? subCategoriaId = dataSubCategoria.id;
                                    isMouseOver[subCategoriaId] = false;
                                    backgroundColor[subCategoriaId] = AppColor.white;
                                    update();
                                },
                
                                child: GestureDetector(
                                    onTap: () => dataSubCategoria.id,
                                    child: Obx(() => ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                            color: backgroundColor[dataSubCategoria.id],
                                            child: Container(
                                                constraints: const BoxConstraints.expand(height: 40),
                                                alignment: Alignment.center,
                                                child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                        const SizedBox(width: 10),
                                                        InkWell(
                                                            onTap: () async{
                                                                FilePickerResult? resultFilePicker = await FilePicker.platform.pickFiles(
                                                                    type: FileType.image,
                                                                    allowMultiple: false
                                                                );

                                                                if ( resultFilePicker != null ){
                                                                    PlatformFile file = resultFilePicker.files.first;
                                                                    String fileName = file.name;
                                                                    String filePath = 'assets/producto/$fileName';

                                                                    await dataSController.updateImagen(dataSubCategoria.id!, filePath);
                                                                }
                                                                
                                                            },
                                                            child: ClipRRect(
                                                                borderRadius: BorderRadius.circular(100),
                                                                child: Container(
                                                                    width: 30,
                                                                    height: 30,
                                                                    color: AppColor.lead,
                                                                    child: Image.asset('assets/images/made.png'),
                                                                ),
                                                            ),
                                                        ),
                                                        
                                                        const SizedBox(width: 20),
                                                        Expanded(flex: 5, child: Text(dataSubCategoria.nombre, style: const TextStyle(fontWeight: FontWeight.bold))),
                                                        Expanded(flex: 3, child: Text('${dataSubCategoria.precio.toString()}   €', style: const TextStyle(fontWeight: FontWeight.bold))),

                                                        Expanded(
                                                            flex: 3, child: Text(
                                                                DateFormat('mm:ss').format(DateTime.parse(dataSubCategoria.time.toString())),
                                                            )
                                                        ),

                                                        if (dataSubCategoria.activo == true)
                                                            Expanded( flex: 3, child: Icon(Icons.toggle_on, color: AppColor.orange, size: 40) ),
                                                        if (dataSubCategoria.activo == false)
                                                            Expanded( flex: 3, child: Icon(Icons.toggle_off, color: AppColor.orange, size: 40)),

                                                        Expanded(
                                                            flex: 2,
                                                            child: Row(
                                                                children: [
                                                                    InkWell(
                                                                        onTap: () {
                                                                            String? formatedTime;
                                                                            if (dataSubCategoria.time != null && dataSubCategoria.time!.isNotEmpty){
                                                                                // Intenta analizar la cadena de tiempo en un objeto DateTime
                                                                                DateTime parsedDateTime = DateTime.parse(dataSubCategoria.time!);
                                                                                // Formatea los minutos y segundos
                                                                                formatedTime = '${parsedDateTime.minute}:${parsedDateTime.second}';
                                                                            } else {
                                                                                formatedTime = '';
                                                                            }
                                                                            showFormDialogEdit(SubCategoriaData(id: dataSubCategoria.id, idcategoria: dataSubCategoria.idcategoria, nombre: dataSubCategoria.nombre, descripcion: dataSubCategoria.descripcion, 
                                                                                                                activo: dataSubCategoria.activo, precio: dataSubCategoria.precio, time: formatedTime, calorias: dataSubCategoria.calorias                                    
                                                                            ));
                                                                        },
                                                                        child: const FaIcon(FontAwesomeIcons.pen, color: Colors.green, size: 20 )
                                                                    ),
                                                
                                                                    const SizedBox(width: 20),
                                                                    InkWell(
                                                                        onTap: () {
                                                                            // ignore: unused_local_variable
                                                                            final DataSubCategoriaController dataSubCategoriaController = Get.put(DataSubCategoriaController());
                                                                            Get.find<DataSubCategoriaController>().deleteData(dataSubCategoria.id.toString());
                                                                        },
                                                                        child: FaIcon(FontAwesomeIcons.trash, color: AppColor.pink, size: 18 )
                                                                    ),
                                                                ],
                                                            ),
                                                        ),
                                                        
                                                    ],
                                                ),
                                            ),
                                        ),
                                    )),
                                ),
                            )
                        ],
                    ),
                ),
            );
            cardListSubCategoria.value = tempWidget;
        } catch (e) {
            print('error en getDatamodelSubCategoria 3 $e');
            cardListSubCategoria.value = [];
            // Maneja excepciones específicas o registra un mensaje de error genérico aquí
        }
    }



    Future<void> getIdCategoria({required String idCategoria}) async {
        print('idCategoria: $idCategoria');
        idCategoriaRx.value = idCategoria;
        await getDataModelSubCategoria();

        // Actualiza la vista
        update();
    }
}
