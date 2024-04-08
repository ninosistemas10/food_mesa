
import 'package:dashboard_bloc/app/presentation/ui/login/view/login_view.dart';
import 'package:dashboard_bloc/app/presentation/ui/login/view/register_view.dart';
import 'package:dashboard_bloc/app/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';







class DetailSide extends StatelessWidget {
    final Animation<double> _animation;
    

    const DetailSide({ 
        required Animation<double> animation,
        Key? key, 
    }) : _animation = animation, super(key: key);



    @override
    Widget build(BuildContext context) {
        

    
            return Align(
                alignment: Alignment(- _animation.value, 0.0),
                child: SizedBox(    
                    width: MediaQuery.of(context).size.width * 0.63,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                                Text( _animation.value < 0.0                                    
                                    ? 'Inicia sesion con tu cuenta'
                                    : 'Crea una cuenta',style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: AppColor.blueDark),
                                ),
            
            
                                Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 25),
                                    child: SizedBox(
                                        width: 170,
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                                Container(
                                                    height: 50,
                                                    width: 50,                                                   
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black26),
                                                        borderRadius: BorderRadius.circular(30)
                                                    ),
                                                    child: const  Icon(FontAwesomeIcons.facebook, size: 30, color: Colors.grey),
                                                ),
            
                                                Container(
                                                    height: 50,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                        border: Border.all( color: Colors.black26 ),
                                                        borderRadius: BorderRadius.circular(30),
                                                    ),
            
                                                    child: const Icon(FontAwesomeIcons.google, size: 30, color: Colors.grey),
                                                ),
            
                                                Container(
                                                    height: 50,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                        border: Border.all( color: Colors.black26 ),
                                                        borderRadius: BorderRadius.circular(30),
                                                    ),
                                                    child: const Icon(FontAwesomeIcons.apple, size: 30, color: Colors.grey),
                                                ),
        
                                            ],
                                        ),
                                    )
                                ),
            
                                Text(_animation.value < 0.0
                                    ? 'o use su correo electronico para registrarse:'
                                    : 'o use su cuenta de correo electronico', style: const  TextStyle(fontSize: 14, color: Colors.black54),
                                ),
            
                                _animation.value < 0.0
                                ? const SizedBox(height: 20)
                                : const SizedBox(),
                                    
                                _animation.value < 0.0
        
                                ? const LoginView()
                                :  const RegisterView(),
        
                                _animation.value < 0.0
                                ? const SizedBox()
                                : const SizedBox(height: 20),
            
                                _animation.value < 0.0
                                ? Container()
                                : Text('olvidaste tu contraseña?', style: TextStyle(fontSize: 14, color: AppColor.blueDark)),
            
                            ],
                    ),
                ),
            );
        }
        
    }




