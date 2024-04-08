import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dashboard_bloc/app/utils/app_colors/app_colors.dart';

class TextTiempo extends StatefulWidget {
  final String label;
  final String placeHolder;
  final IconData? icon;
  final bool isTextArea;
  final double width;
  final TextEditingController controller;
  final bool error;
  final void Function(String) onChanged;

  const TextTiempo({
    Key? key,
    required this.label,
    required this.placeHolder,
    this.icon,
    this.isTextArea = false,
    required this.width,
    required this.controller,
    this.error = false,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<TextTiempo> createState() => _TextTiempoState();
}

class _TextTiempoState extends State<TextTiempo> {
    bool isPlaceHolderActive = false;

  @override
  void initState() {
    super.initState();
    //verifica si el controlador ya tiene texto
     if (widget.controller.text.isNotEmpty) {
      isPlaceHolderActive = true;
    }

    // Agrega un listener al controlador para rastrear cambios en el texto
    widget.controller.addListener(updatePlaceHolder);
  }

  void updatePlaceHolder() {
    setState(() {
      isPlaceHolderActive = widget.controller.text.isNotEmpty;
      widget.onChanged(widget.controller.text); // Llamamos a onChanged
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isPlaceHolderActive ? widget.label : '',
            style: TextStyle(
              fontSize: 13,
              color: widget.error ? AppColor.lead : isPlaceHolderActive ? AppColor.white : Colors.grey[100],
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              border: Border.all(color: widget.error ? AppColor.primaryColor : AppColor.white),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Align(
              alignment: Alignment.center,
              child: TextField(
                cursorColor: AppColor.white,
                controller: widget.controller,
                keyboardType: TextInputType.datetime,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(5),
                  _TimeFormatter(),
                ],
                onChanged: widget.onChanged,
                maxLines: widget.isTextArea ? 6 : null,
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: isPlaceHolderActive ? '' : widget.placeHolder, 
                  suffixIcon: widget.icon != null ? Icon(widget.icon, color: widget.error ? AppColor.yellow : AppColor.yellow) : null,
                  suffixText: 'min    ', // Añade el texto 'min' como sufijo
                  //suffixStyle: TextStyle(color: widget.error ? AppColor.lead : AppColor.white),
                  hintStyle: TextStyle(color: isPlaceHolderActive ? AppColor.white : AppColor.lead),
                ),
                style: TextStyle(color: widget.error ? AppColor.lead : AppColor.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(updatePlaceHolder);
    super.dispose();
  }
}

class _TimeFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Se asegura de que el texto tenga el formato mm:ss
    if (newValue.text.length > 5) {
      return oldValue;
    }

    // Añade ':' automáticamente después de que se hayan ingresado 2 caracteres
    if (newValue.text.length == 3 && !oldValue.text.endsWith(':')) {
      return TextEditingValue(
        text: '${oldValue.text}:',
        selection: TextSelection.collapsed(offset: oldValue.selection.end + 1),
      );
    }

    // Permite solo dígitos y ':' en la entrada
    if (RegExp(r'^[0-9:]*$').hasMatch(newValue.text)) {
      return newValue;
    } else {
      return oldValue;
    }
  }
}
