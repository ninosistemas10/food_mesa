import 'package:dashboard_bloc/app/controller/data_sub_categoria_controller.dart';
import 'package:dashboard_bloc/app/controller/menu_controller.dart';
import 'package:dashboard_bloc/app/controller/sub_categoria_controller.dart';
import 'package:dashboard_bloc/app/data/repository/sub_categoria_repository.dart';

import 'package:dashboard_bloc/app/presentation/categoria/widget/dropdown_item.dart';
import 'package:dashboard_bloc/app/presentation/categoria/widget/dropdown_widget%20_add.dart';
import 'package:dashboard_bloc/app/presentation/categoria/widget/text_decimal.dart';
import 'package:dashboard_bloc/app/presentation/categoria/widget/text_field.dart';
import 'package:dashboard_bloc/app/presentation/categoria/widget/text_price.dart';
import 'package:dashboard_bloc/app/presentation/categoria/widget/text_tiempo.dart';
import 'package:dashboard_bloc/app/presentation/ui/login/widget/button_widget.dart';
import 'package:dashboard_bloc/app/presentation/widget/error_message.dart';
import 'package:dashboard_bloc/app/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


// ignore: must_be_immutable
class SubCategoriaPage extends StatefulWidget {
    const SubCategoriaPage({super.key});

  @override
  State<SubCategoriaPage> createState() => _SubCategoriaPageState();
}

class _SubCategoriaPageState extends State<SubCategoriaPage> {

    SubCategoriaRepository subCategoriaRepository = SubCategoriaRepository();
    final MenunController menuController = Get.find<MenunController>();

    final TextEditingController nombreSubCategoria = TextEditingController();
    final TextEditingController descriptionSubCategoria = TextEditingController();
    final TextEditingController precioSubCategoria = TextEditingController();
    final TextEditingController tiempoSubCategoria = TextEditingController();
    final TextEditingController caloriasSubCategoria = TextEditingController();

    late final DataSubCategoriaController dataSubCategoriaController;

    @override
    void initState(){
        super.initState();
        Get.put(DataSubCategoriaController());
    }

    bool dataValidacion () {
        if (nombreSubCategoria.text.trim() == '') {
            Message.taskErrororWarning('Delivery', 'Escribe el Producto');
            return false;
        } else if (descriptionSubCategoria.text.trim() == '') {
            Message.taskErrororWarning('Delivery', 'Escriba la descripcion');
        }
        return true;
    }

    final List<ItemDropdown> listStatus = [
        ItemDropdown(label: 'Activo', value: 'Activo'),
        ItemDropdown(label: 'Inactivo', value: 'Inactivo')
    ];

    ItemDropdown? selectStatus;

    bool isActivo = false;

    RxString idCategoriaRx = ''.obs;
    RxString nomCategoriaRx = ''.obs;

    

    @override
    Widget build(BuildContext context) {
        late SubCategoriaController subCategoriaController = Get.put(SubCategoriaController());
        
        return Container(
            decoration: BoxDecoration( borderRadius: BorderRadius.circular(20), color: AppColor.white ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
                
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            
                            
                            Text( 'Categoria: ${subCategoriaController.nombreCategoriaRx.value}' , style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.black, fontSize: 25)),
                            ButtonWidget(text: 'Agregar', fColor: AppColor.yellow, onPress: () {showFormDialogAdd(context);}, tColor: AppColor.black)

                        ],
                    ),

                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        decoration: BoxDecoration(
                            color: AppColor.blue,
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                        ),

                        child: Column(
                            
                            children: [
                                
                                Row(
                                    
                                    children: [
                                        Expanded(
                                            flex: 5,
                                            child: Text('       Producto', style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.green, fontSize: 15)),
                                        ),

                                        Expanded(
                                            flex: 3,
                                            child: Text('Precio', style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.green, fontSize: 15))
                                        ),

                                        Expanded(
                                            flex: 4,
                                            child: Text('Tiempo Prepacion', style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.green, fontSize: 15))
                                        ),

                                        Expanded(
                                            flex: 3,
                                            child: Text('Estado', style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.green, fontSize: 15))
                                        ),

                                        // Expanded(
                                        //     flex: 2,
                                        //     child: Text('Opcines', style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.green, fontSize: 15))
                                        // ),
                                    ],
                                )
                            ],
                        ),
                    )

                ],
            ),
        );
    }

    showFormDialogAdd(context) {
        nombreSubCategoria.clear();
        descriptionSubCategoria.clear();
        showDialog(
            context: context,
            builder: (buildercontext) {

                return Dialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    backgroundColor: AppColor.bgSideMenu,
                    child: SizedBox(
                        width: 400,
                        height: 500,
                        child: SingleChildScrollView( // Agregar SingleChildScrollView aquí
                            child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    
                                    children: [
                                        Row(         
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                                IconButton( onPressed: () { Navigator.of(context).pop(); },
                                                    icon: Icon(Icons.arrow_back, color: AppColor.white),
                                                ),
                                                Text('Nueva Categoria', style: TextStyle(color: AppColor.yellow)),
                                                
                                                TextButton( onPressed: () { 
                                                    //if (dataValidacion()) {
                                                        late SubCategoriaController subCategoriaController = Get.put(SubCategoriaController());

                                                        String tiempoText = tiempoSubCategoria.text;//obteber la cade de tiempo
                                                        List<String> parts = tiempoText.split(':');//Dividir la cade ne partes separadas por ':'
                                                        int minutos = int.parse(parts[0]);//obtener los minutos y segundo de la lista de partes
                                                        int segundos = int.parse(parts[1]);
                                                        DateTime ahora = DateTime.now();//crear un objeto DateTime con la fecha actual y ajustar solo los minutos y segundos
                                                        DateTime  tiempo = DateTime(ahora.year, ahora.month, ahora.day, ahora.hour, minutos, segundos);
                                                        String tiempoSerializado = '${DateFormat('yyyy-MM-ddTHH:mm:ss').format(tiempo)}Z';
                                                        //tiempoSerializado = tiempoSerializado.substring(0, tiempoSerializado.length -4);

                                                         //String tiempoSerializado = DateFormat('yyyy-MM-ddTHH:mm:ss').format(tiempo);
                                                        String idCategoria = subCategoriaController.idCategoriaRx.value;
                                                        double calorias = double.parse(caloriasSubCategoria.text);
                                                        double price = double.parse(precioSubCategoria.text);
                                                        //DateTime tiempoP = DateTime.parse(tiempo);

                                                        print('tiempo:  $tiempoSerializado');
                                                        isActivo = selectStatus != null && selectStatus?.value == 'Activo';
                                                        print('llego hasta aqui1');
                                                        Get.find<DataSubCategoriaController>().postData(
                                                            idCategoria, nombreSubCategoria.text, descriptionSubCategoria.text, isActivo, price, calorias, tiempoSerializado
                                                        );
                                                        
                                                    //}
                                                    print('llegue hasta aqui2');   
                                                    },
                                                    child: const Text('Grabar', style: TextStyle(color: Colors.green))
                                                )
                                            ],
                                        ),

                                        const SizedBox(height: 15),
                                        TextFieldWidget(label: '   Nombre', placeHolder: 'Nombre', width: 320, controller: nombreSubCategoria, error: true, onChanged: (text) {}),
                                        
                                        const SizedBox(height: 15),
                                        TextFieldWidget(label: '   Descripcion', placeHolder: 'Descripcion', width: 320, controller: descriptionSubCategoria, error: true, onChanged: (text) {}),
                                        
                                        const SizedBox(height: 15),
                                        Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                                const SizedBox(height: 30),
                                                DropDownWidgetAdd(label: '   Estado', list: listStatus, onSelect: (select) {selectStatus = select;}, whidt: 150, itemWidht: 90, error: true),
                                                
                                                const SizedBox(width: 20),
                                                TextPrice(label: '   Precio', placeHolder: '00.00', width: 150, controller: precioSubCategoria, onChanged: (text) { }, error:  true),
                                            ],
                                        ),
                                            
                                        const SizedBox(height: 15),
                                        Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                                TextTiempo(label: '   Tiempo', placeHolder: '00:00', width: 150, controller: tiempoSubCategoria, onChanged: (text) {}, error: true,),
                                                    
                                                const SizedBox(width: 20),
                                                TextCalorias(label: '   Calorias', placeHolder: '0.0', width: 150, controller: caloriasSubCategoria, onChanged: (text) {}, error:  true,)
                                            ],
                                        )
                                    ],
                                ),
                            ),
                        ),
                    ),
                );
            },
        );
    }
}