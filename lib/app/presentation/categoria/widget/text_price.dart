import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dashboard_bloc/app/utils/app_colors/app_colors.dart';

class TextPrice extends StatefulWidget {
  final String label;
  final String placeHolder;
  final IconData? icon;
  final double width;
  final TextEditingController controller;
  final bool error;
  final void Function(String) onChanged;

  const TextPrice({
    Key? key,
    required this.label,
    required this.placeHolder,
    this.icon,
    required this.width,
    required this.controller,
    this.error = false,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<TextPrice> createState() => _TextPriceState();
}

class _TextPriceState extends State<TextPrice> {
  bool isPlaceHolderActive = false;

  @override
  void initState() {
    super.initState();
    // Verifica si el controlador ya tiene texto
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
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^[0-9,.]*$')),
                ], // Permite números, comas y puntos
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: isPlaceHolderActive ? '' : widget.placeHolder, // Agrega el símbolo del euro al final del placeholder
                  suffixText: '€    ', // Añade el texto 'min' como sufijo
                  suffixIcon: widget.icon != null ? Icon(widget.icon, color: widget.error ? AppColor.yellow : AppColor.yellow) : null,
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
