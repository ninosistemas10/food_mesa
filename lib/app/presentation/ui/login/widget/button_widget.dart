import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
    final String text;
    final Color fColor;
    final Color tColor;
    final VoidCallback onPress;

    const ButtonWidget({Key? key,
        required this.text,
        required this.fColor,
        required this.onPress,
        required this.tColor,
    }) : super(key: key);

    @override
    State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
    bool isHovered = false;

    @override
    Widget build(BuildContext context) {
        return Container(
            height: 70,
            width: 150,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: MouseRegion(
                onEnter: (_) {
                    setState(() {
                        isHovered = true;
                    });
                },
                onExit: (_) {
                    setState(() {
                        isHovered = false;
                    });
                },
                child: ElevatedButton(
                    onPressed: widget.onPress,
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(isHovered ? const Color.fromARGB(0, 234, 94, 94) : widget.fColor), // Cambiar a fondo transparente cuando se pasa el cursor
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                        )),
                    ),
                    child: Text( widget.text, style: TextStyle(color: isHovered ? widget.fColor : widget.tColor, fontSize: 13)),
                ),
            ),
        );
    }
}
