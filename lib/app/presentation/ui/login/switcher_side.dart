import 'package:dashboard_bloc/app/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';



class SwitcherSide extends StatefulWidget {
    const SwitcherSide({
        Key? key,
        required Animation<double> animation,
        required this.containerWidth,
        required this.welcomeText,
        required AnimationController controller,
        required this.width,
        required this.alignText,
    }) : 
    _animation = animation,
    _controller = controller,
    super(key: key);

    final Animation<double> _animation;
    final double containerWidth;
    final double welcomeText;
    final AnimationController _controller;
    final double width;
    final double alignText;

    @override
    State <SwitcherSide> createState() => _SwitcherSideState();

}

class _SwitcherSideState extends State<SwitcherSide> {
    @override
    Widget build(BuildContext context) {
        return Align(
            alignment: Alignment(widget._animation.value, 0.0),
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width * 0.38 + widget.containerWidth,
                decoration: BoxDecoration( 
                    image: DecorationImage(
                        image: const AssetImage('assets/images/made.png'),
                        colorFilter: ColorFilter.mode(AppColor.black.withOpacity(0.5), BlendMode.srcOver),
                        fit: BoxFit.cover, alignment: Alignment(widget._animation.value, 0.0)
                    )
                ),

                clipBehavior: Clip.hardEdge,
                child: SizedBox(
                    width: 300,
                    child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                Stack(
                                    children: [
                                        Align(
                                            alignment: Alignment(widget.welcomeText, -0.35),
                                            child: SizedBox(
                                                width: 350,
                                                height: 160,
                                                child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                        Text( 
                                                            widget._animation.value > 0.0
                                                            ? 'Hola, Amigo'
                                                            : 'Bienvenido', style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: AppColor.white),  
                                                            textAlign: TextAlign.center,
                                                        ),

                                                        const SizedBox(height: 10),
                                                        Text(
                                                            widget._animation.value > 0.0
                                                            ? 'Intruduce tus datos personales y comienza tu viaje con nosotros'
                                                            : 'Para mantenerse conectado con nosotros, inicie sesion',
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(fontSize: 18, color: AppColor.white),
                                                        ),

                                                        const SizedBox(height: 20)
                                                    ],
                                                ),
                                            ),
                                        )
                                    ],
                                ),
                                const SizedBox(height: 40),

                                ElevatedButton(
                                    onPressed: () {
                                        setState(() {
                                            if (widget._controller.isCompleted) {
                                                widget._controller.reverse();
                                            } else {
                                                widget._controller.forward();
                                            }
                                        });
                                    },
                                
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(Colors.transparent), // Fondo blanco
                                        overlayColor: MaterialStateProperty.all(Colors.white.withOpacity(0.2)), // Color de superposición transparente
                                        foregroundColor: MaterialStateProperty.all(Colors.white), // Color del texto blanco
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30.0),
                                                side: const BorderSide(color: Colors.white, width: 2.0), // Borde blanco
                                            ),
                                        ),
                                        padding: MaterialStateProperty.all(const EdgeInsets.all(0.0)),
                                    ),

                                    
                                    child: Container(
                                        height: 60.0,
                                        width: widget.width,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30.0),
                                            border: Border.all(color: Colors.white, width: 2.0),
                                        ),
                                    
                                        child: Center(
                                            child: Stack(
                                                children: [
                                                    Align(
                                                        alignment: Alignment(widget.alignText, 0.0),
                                                        child: Opacity(
                                                            opacity: (widget._animation.value < 0.0)
                                                            ? widget._animation.value.abs()
                                                            : 0.0,
                                                            child: const Text( 'Ingresar', style: TextStyle( fontSize: 17.0, color: Colors.white)),
                                                        ),
                                                    ),

                                                    Align(
                                                        alignment: Alignment(widget.alignText, 0.0),
                                                        child: Opacity(
                                                            opacity: (widget._animation.value > 0.0)
                                                            ? widget._animation.value.abs()
                                                            : 0.0,
                                                            child: const Text( 'Registrarse', style: TextStyle( fontSize: 15.0, color: Colors.white) ),
                                                        ),
                                                    ),
                                                ],
                                            ),
                                        ),
                                    ),
                                ) 
                            ],
                        ),
                    ),
                ),
            ),
        );
    }
}
