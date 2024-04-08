import 'package:dashboard_bloc/app/data/model/model_categoria/category_data.dart';
import 'package:dashboard_bloc/app/presentation/categoria/widget/dropdown_item.dart';
import 'package:dashboard_bloc/app/presentation/categoria/widget/dropdown_widget_edit.dart';
import 'package:dashboard_bloc/app/presentation/categoria/widget/text_field.dart';
import 'package:dashboard_bloc/app/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditFormWidget extends StatelessWidget {
    final CategoryData modelCategory;

    EditFormWidget({ Key? key,
        required this.modelCategory,
    }) : super(key: key);

    final List<ItemDropdown> listStatus = [
        ItemDropdown(label: 'Activo', value: 'Activo'),
        ItemDropdown(label: 'Inactivo', value: 'Inactivo'),
    ];

    ItemDropdown? selectStatus;
    bool isActivo = false;

    final TextEditingController nameCategoria = TextEditingController();
    final TextEditingController descriCategoria = TextEditingController();
    final ValueNotifier<bool> activoCategoria = ValueNotifier<bool>(false);

    void showFormDialogEdit(BuildContext context, CategoryData modelCategory) {
        nameCategoria.text = modelCategory.nombre;
        descriCategoria.text = modelCategory.description ?? '';
        activoCategoria.value = modelCategory.activo;

        showDialog(
            context: context,
            builder: (builderContext) => _buildDialog(builderContext),
        );
    }

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
                                    
                                    Text('Modificar Categoria', style: TextStyle(color: AppColor.yellow)),
                                    
                                    TextButton(
                                        onPressed: () {
                                            // Realiza las operaciones que necesitas al presionar el botón
                                        },
                                        child: const Text('Actualizar', style: TextStyle(color: Colors.green)),
                                    )
                                ],
                            ),

                            const SizedBox(height: 15),
                            TextFieldWidget( label: 'Nombre', placeHolder: 'Nombre', width: 300, controller: nameCategoria, error: true, onChanged: (text) {},),

                            const SizedBox(height: 15),
                            TextFieldWidget( label: 'Descripcion', placeHolder: 'Descripcion', width: 300, controller: descriCategoria, error: true, onChanged: (text) {} ),
            
                            const SizedBox(height: 30),
                            DropDownWidgetEdit( label: 'Estado', list: listStatus, 
                                onSelect: (select) {
                                    selectStatus = select;
                                },
                                defaultValue: activoCategoria.value ? 'Activo' : 'Inactivo', // Muestra el valor actual
                                whidt: 300,
                                itemWidth: 230,
                                error: true,
                            ),
                        ],
                    ),
                ),
            ),
        );
    }

    @override
    Widget build(BuildContext context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
            // Llama a la función directamente después de que el árbol de widgets se haya construido
            showFormDialogEdit(context, modelCategory);
        });

        // Devuelve un contenedor vacío ya que no se necesita mostrar nada aquí
        return const SizedBox.shrink();
    }
}
