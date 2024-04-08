

import 'package:dashboard_bloc/app/controller/data_categoria_controller.dart';
import 'package:dashboard_bloc/app/controller/menu_controller.dart';
import 'package:dashboard_bloc/app/controller/sub_categoria_controller.dart';
import 'package:dashboard_bloc/app/data/model/model_categoria/category_data.dart';

import 'package:dashboard_bloc/app/data/model/model_categoria/model_category.dart';
import 'package:dashboard_bloc/app/data/model/model_sub_categoria/sub_categoria_model.dart';
import 'package:dashboard_bloc/app/data/repository/category_repository.dart';
import 'package:dashboard_bloc/app/presentation/categoria/categorias_page.dart';
import 'package:dashboard_bloc/app/presentation/categoria/widget/dropdown_item.dart';
import 'package:dashboard_bloc/app/presentation/categoria/widget/dropdown_widget_edit.dart';
import 'package:dashboard_bloc/app/presentation/categoria/widget/text_field.dart';


import 'package:dashboard_bloc/app/utils/app_colors/app_colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';



class CategoriaController extends GetxController {
    CategoryRepository categoryRepository = CategoryRepository();
    late SubCategoriaController subCategoriaController = Get.find<SubCategoriaController>();

    final TextEditingController nameCategoria = TextEditingController();
    final TextEditingController descriCategoria = TextEditingController();
    RxList<Widget> cardListCategory = <Widget>[].obs;
    
    
    final RxMap<String?, bool> _isMouseOver = <String, bool>{}.obs;
    final RxMap<String?, Color> backgroundColor = <String, Color>{}.obs;

    final MenunController menunController = Get.find<MenunController>();
    final DataCategoriaController dataController = Get.find<DataCategoriaController>();

    
    //get activoCategoria => null;
    RxString idCategoriaRx = ''.obs;
    RxString nombreCategoriaRx = ''.obs;
    RxList<SubCategoriaModel> subCategoriaList = <SubCategoriaModel>[].obs;
    

    @override
    void onReady() async {
        subCategoriaController = Get.put(SubCategoriaController());
        super.onReady();
    }

    Future<void> callGetDataModelCategoria() async {
        await  getDataModelCategory();
    }
    
    //-------------------EDITAR----------------------//

    final List<ItemDropdown> listStatus = [
        ItemDropdown(label: 'Activo', value: 'Activo'),
        ItemDropdown(label: 'Inactivo', value: 'Inactivo'),
    ];

    ItemDropdown? selectStatus;
    bool isActivo = false;
    final TextEditingController idCategoria = TextEditingController();
    final TextEditingController nombreCategoria = TextEditingController();
    final TextEditingController descriptionCategoria = TextEditingController();
    final ValueNotifier<bool> activoCategoria = ValueNotifier<bool>(false);

    void showFormDialogEdit(CategoryData modelCategoriaData) {
        idCategoria.text = modelCategoriaData.id!;
        nombreCategoria.text = modelCategoriaData.nombre;
        descriptionCategoria.text = modelCategoriaData.description!;
        activoCategoria.value = modelCategoriaData.activo;

        showDialog(
            context: Get.context!,
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

                                    Text('Editar Categoria', style: TextStyle(color: AppColor.yellow)),
                                    TextButton(
                                        onPressed: () async {
                                            try {
                                                print('updateNoImage : ${idCategoria.text}');
                                                DataCategoriaController dataCategoriaController = Get.find<DataCategoriaController>();
                                                await dataCategoriaController.updateNoImagen(idCategoria.text, nombreCategoria.text, descriptionCategoria.text, activoCategoria.value);
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
                            TextFieldWidget( label: 'Nombre', placeHolder: 'Nombre', width: 300, controller: nombreCategoria, error: true, onChanged: (text) {} ),
                        
                            const SizedBox(height: 15),
                            TextFieldWidget( label: 'Descripcion', placeHolder: 'Descripcion', width: 300, controller: descriptionCategoria, error: true, onChanged: (text) {} ),
            
                            const SizedBox(height: 30),
                            DropDownWidgetEdit( label: 'Estado', list: listStatus, onSelect: (select) { selectStatus = select; }, defaultValue: activoCategoria.value ? 'Activo' : 'Inactivo', whidt: 300, itemWidth: 230, error: true ),
                        ],
                    ),
                ),
            ),
        );
    }

  //_______________________________________________//


    Future<void> getDataModelCategory() async {
        ModelCategory categoryData = await categoryRepository.getDataModelCategory();
        List<Widget> tempWidget = [];
        cardListCategory.clear();
        tempWidget.add(CategoriasPage());
        tempWidget.add(
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                        for (var modelCategory in categoryData.data)
                        MouseRegion(
                            cursor: SystemMouseCursors.click,
                            onEnter: (_) {
                                print(modelCategory.id);
                                final  categoryId = modelCategory.id;
                                subCategoriaController.idCategoriaRx.value = categoryId!;
                                subCategoriaController.nombreCategoriaRx.value = modelCategory.nombre;

                                _isMouseOver[categoryId] = true;
                                backgroundColor[categoryId] = AppColor.blueDark.withOpacity(.1);
                                update(); // Actualizar el estado para reflejar el cambio
                            },
                            onExit: (_) {
                                final String? categoryId = modelCategory.id;
                                _isMouseOver[categoryId] = false;
                                backgroundColor[categoryId] = Colors.white;
                                update(); // Actualizar el estado para reflejar el cambio
                            },

                            child: GestureDetector(
                                onTap: () {},
                                child: Obx(()=>
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                            color: backgroundColor[modelCategory.id],
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
                                                            onTap: () async {
                                                                String? idCa = modelCategory.id;
                                                                CategoryData categoriaActual = await dataController.getCategoryDetails(idCa!);
                                                                try{
                                                                    FilePickerResult? resultFilePicker = await FilePicker.platform.pickFiles(
                                                                        type: FileType.image,
                                                                        allowMultiple: false,
                                                                    );

                                                                    if (resultFilePicker != null) {
                                                                        PlatformFile file = resultFilePicker.files.first;
                                                                        String fileName = file.name;
                                                                        String filePath = 'assets/categoria/$fileName';
                                                                        String? description = categoriaActual.description;

                                                                        await dataController.updateImage(idCa, filePath, categoriaActual.nombre, description, categoriaActual.activo);
                                                                        menunController.selectedMenu('');
                                                                        menunController.selectedMenu('Categoria');
                                                                    }
                                                                } catch (e) {
                                                                    print('Error actualizando CategoryData: $e');
                                                                }
                                                            },

                                                            child: ClipRRect(
                                                                borderRadius: BorderRadius.circular(100),
                                                                child: Container(
                                                                    width: 30,
                                                                    height: 30,
                                                                    color: Colors.grey[400]!,
                                                                    child: Image.asset(modelCategory.images!),
                                                                    
                                                                ),
                                                            )     
                                                        ),
                                        
                                                        const SizedBox(width: 20),
                                                        Expanded(
                                                            flex: 3,
                                                            child: Text(modelCategory.nombre),
                                                        ),

                                                        Expanded(
                                                            flex: 3,
                                                            child: Text(modelCategory.description.toString()),
                                                        ),
                                                                                                            
                                                        if (modelCategory.activo == true)
                                                            Expanded(
                                                            flex: 4,
                                                            child: Icon(Icons.toggle_on, color: AppColor.orange, size: 40),
                                                        ),
                                                        if (modelCategory.activo == false)
                                                        Expanded(
                                                            flex: 4,
                                                            child: Icon(Icons.toggle_off, color: AppColor.orange, size: 40,),
                                                        ),
                                                
                                                        Expanded(
                                                            flex: 3,
                                                            child: Row(
                                                                children: [
                                                                    InkWell(
                                                                        onTap: () {
                                                                            showFormDialogEdit( CategoryData(id: modelCategory.id, nombre: modelCategory.nombre, description: modelCategory.description, activo: modelCategory.activo));
                                                                        },
                                                                        child: const FaIcon(FontAwesomeIcons.pen, color: Colors.green, size: 20 )
                                                                    ),
                                                
                                                                    const SizedBox(width: 20),
                                                                    InkWell(
                                                                        onTap: () {
                                                                        
                                                                            // ignore: unused_local_variable
                                                                            final DataCategoriaController dataController = Get.put(DataCategoriaController());
                                                                            Get.find<DataCategoriaController>().deleteData(modelCategory.id.toString());
                                                            
                                                                        },
                                                                        child: FaIcon(FontAwesomeIcons.trash, color: AppColor.pink, size: 18 )
                                                                    ),
                                                                
                                                                    const SizedBox(width: 50),
                                                                    GestureDetector (
                                                                        onTap: () {
                                                                            menunController.selectedMenu('');
                                                                            menunController.selectedMenu('Producto');
                                                                        },
                                                                        child: FaIcon( FontAwesomeIcons.circleChevronRight, color: AppColor.blueDark, size: 20)
                                                                    ),
                                                                ],
                                                            ),
                                                        ),
                                                    ],
                                                ),
                                                
                                            ),
                                        ),
                                    ),
                                )
                            ),
                        )
                    ],
                ),
            ),
        );
        cardListCategory.value = tempWidget;
    }




}

