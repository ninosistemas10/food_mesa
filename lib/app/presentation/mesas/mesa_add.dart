// ignore_for_file: library_private_types_in_public_api

import 'dart:typed_data';
import 'dart:ui';

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:dashboard_bloc/app/controller/data_mesa_controller.dart';
import 'package:dashboard_bloc/app/controller/menu_controller.dart';
import 'package:dashboard_bloc/app/presentation/categoria/widget/dropdown_item.dart';
import 'package:dashboard_bloc/app/presentation/categoria/widget/dropdown_widget%20_add.dart';
import 'package:dashboard_bloc/app/presentation/categoria/widget/text_field.dart';
import 'package:dashboard_bloc/app/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';  
import 'package:qr_flutter/qr_flutter.dart';

class AddMesaWidget extends StatefulWidget {
    final VoidCallback onTap;
    const AddMesaWidget({Key? key, required this.onTap}) : super(key: key);
  
    @override
    _AddMesaWidgetState createState() => _AddMesaWidgetState();
}

class _AddMesaWidgetState extends State<AddMesaWidget> {
    final MenunController menunController = Get.find<MenunController>();
    bool isMouseOver = false;
    final TextEditingController nameMesa = TextEditingController(text: '');
    final TextEditingController urlMesa = TextEditingController();
    String data = '';

    ItemDropdown? selectStatus;
    bool isActivo = false;
    final List<ItemDropdown> listStatus = [
        ItemDropdown(label: 'Activo', value: 'Activo'),
        ItemDropdown(label: 'Inactivo', value: 'Inactivo')
    ];

    Future<void> generateAndSaveQR() async {
        if (urlMesa.text.isEmpty || nameMesa.text.isEmpty) {
            // Validar que la URL y el nombre no estén vacíos
            return;
        }
        // Usar un carácter especial para separar la URL y el nombre de la mesa
        const separator = '@';
        final qrData = "${urlMesa.text}$separator${nameMesa.text}";
        final qrPainter = QrPainter(
            data: qrData,
            version: QrVersions.auto,
        );

        final image = await qrPainter.toImage(200);
        final byteData = await image.toByteData(format: ImageByteFormat.png);
        final uint8List = byteData!.buffer.asUint8List();

        saveQrImage(uint8List, 'qr_mesa');
    }

    void saveQrImage(Uint8List bytes, String fileName) {
        final blob = html.Blob([bytes]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        // ignore: unused_local_variable
        final anchor = html.AnchorElement(href: url)
            ..target = 'webSaveQR'
            ..download = '$fileName.png'
            ..click();

            html.Url.revokeObjectUrl(url);
    }

    @override
    Widget build(BuildContext context) {
        return MouseRegion(
            onEnter: (_) => _updateMouseOver(true),
            onExit: (_) => _updateMouseOver(false),
            child: InkWell(
                onTap: () {
                    widget.onTap();
                    showAddModal(context);
                },
                child: Container(
                    margin: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 239, 235, 235),
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                            color: isMouseOver
                            ? const Color.fromARGB(255, 194, 47, 47)
                            : Colors.black,
                        ),
                    ),
                    
                    child: const Center(
                        child: Icon(Icons.add, size: 30, color: Colors.blue),
                    ),
                ),
            ),
        );
    }

    void _updateMouseOver(bool value) {
        setState(() {
            isMouseOver = value;
        });
    }

    void showAddModal(BuildContext context) {
    
        nameMesa.clear();
        showDialog(
            context: context,
            builder: (BuildContext context) {
            return Dialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                backgroundColor: AppColor.bgSideMenu,
                child: Container(
                    padding: const EdgeInsets.all(10),
                    width: 400,
                    height: 700,
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
                                        
                                        Text('Nueva Mesa',
                                        style: TextStyle(color: AppColor.yellow)),
                                        
                                        TextButton(
                                            onPressed: () {
                                                generateAndSaveQR();
                                                // ignore: unused_local_variable
                                                final DataMesaController dataMesaController = Get.put(DataMesaController());
                                                isActivo = selectStatus != null && selectStatus!.value == 'Activo';
                                                Get.find<DataMesaController>().postData( urlMesa.text, nameMesa.text, isActivo);
                                                Get.back();
                                            },
                                            
                                            child: const Text('Grabar',
                                            style: TextStyle(color: Colors.green)),
                                        ),
                                    ],
                                ),
                
                                const SizedBox(height: 15),
                                TextFieldWidget( label: 'Url', placeHolder: 'Url', width: 300, controller: urlMesa, onChanged: (text) {}, error: true),
                        
                                const SizedBox(height: 15),
                                TextFieldWidget( label: 'Nombre', placeHolder: 'Nombre', width: 300, controller: nameMesa, error: true, onChanged: (text) {
                                    setState(() {
                                        data = text;
                                    });
                                }),

                                const SizedBox(height: 25),
                                DropDownWidgetAdd( label: 'Estado', list: listStatus, onSelect: (select) { selectStatus = select; }, whidt: 300, itemWidht: 500, error: true),
                
                                const SizedBox(height: 20),
                                Center(
                                    child: QrImageView( data: data, backgroundColor: Colors.white, version: QrVersions.auto, size: 150 ),
                                ),
                            ],
                        ),
                    ),
                ),
            );
        },
        );
    }
}
