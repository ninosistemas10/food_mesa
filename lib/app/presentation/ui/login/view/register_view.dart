import 'package:dashboard_bloc/app/controller/register_controller.dart';
import 'package:dashboard_bloc/app/presentation/ui/login/valid_controller/register_form_controller.dart';
import 'package:dashboard_bloc/app/presentation/ui/login/widget/custom_input.dart';
import 'package:dashboard_bloc/app/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class RegisterView extends GetView<RegisterController> {
    const RegisterView({super.key});

    @override
    Widget build(BuildContext context) {
        final RegisterFormController formController = Get.put(RegisterFormController());  
        return Column(
            children: [
                Container(
                    margin: const EdgeInsets.only(top: 30),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                        child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 370),
                            child: Form(
                                child: Column(
                                    children:[
                                        TextFormField(
                                            controller: controller.nameController,
                                            style: const TextStyle(color: Colors.grey),
                                            decoration: CustomInputs.loginInputDecoration(
                                                hint: 'Ingrese nombre',
                                                label: 'nombre',
                                                icon: FontAwesomeIcons.user,
                                            ),
                                            onChanged: formController.validateNombre,
                                        ),

                                        const SizedBox(height: 20),
                                        TextFormField(
                                            controller: controller.emailController,
                                            style: const TextStyle(color: Colors.grey),
                                            decoration: CustomInputs.loginInputDecoration(
                                                hint: 'Ingrese email',
                                                label: 'email',
                                                icon: FontAwesomeIcons.envelope,
                                            ),
                                            onChanged: formController.validateEmail,
                                        ),

                                        const SizedBox(height: 20),
                                        TextFormField(
                                            controller: controller.passwordController,
                                            obscureText: true,
                                            style: const TextStyle(color: Colors.grey),
                                            decoration: CustomInputs.loginInputDecoration(
                                                hint: 'contraseña',
                                                label: 'contraseña',
                                                icon: Icons.lock_outline_rounded,
                                            ),
                                            onChanged: formController.validatePassword,
                                        ),
                                    ],
                                ),
                            ),
                        ),
                    ),
                ),
                
                const SizedBox(height: 40),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.black),
                        shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                            ),
                        ),
                    ),
                    
                    onPressed: () {
                        if (!controller.nameController.text.isNotEmpty || !formController.isNombre.value) {
                            Get.snackbar('Error', 'Ingrese un nombre.', backgroundColor: AppColor.blueDark, colorText: AppColor.blueLight);
                        } else if (!controller.emailController.text.isNotEmpty || !formController.isEmailValid.value) {
                            Get.snackbar('Error', 'Ingrese un email válido.', backgroundColor: AppColor.blueDark, colorText: AppColor.blueLight);
                        } else if (!controller.passwordController.text.isNotEmpty || !formController.isPasswordValid.value) {
                            Get.snackbar('Error', 'La contraseña debe tener al menos 6 caracteres.', backgroundColor: AppColor.blueDark, colorText: AppColor.blueLight);
                        } else {
                            // Realizar la acción cuando el formulario es válido
                            controller.registerWithEmail();
                            controller.nameController.clear();
                            controller.emailController.clear();
                            controller.passwordController.clear();
                        }
                    },
                    child: Container(
                        //color: AppColor.blueDark,
                        height: 50.0,
                        width: 200.0,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100.0)),
                        child:  Center(
                            child: GestureDetector(
                                onTap: () {},
                                child: Text('Aceptar', style: TextStyle(color: AppColor.yellow))
                            )
                        ),
                    ),
                ),
            ],
        );
    }
}
