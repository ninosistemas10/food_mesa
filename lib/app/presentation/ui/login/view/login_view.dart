import 'package:dashboard_bloc/app/controller/login_controller.dart';
import 'package:dashboard_bloc/app/presentation/dashboard/widget/custom_input.dart';
import 'package:dashboard_bloc/app/presentation/ui/login/valid_controller/login_form_controller.dart';
import 'package:dashboard_bloc/app/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
    const LoginView({super.key});

    @override
    Widget build(BuildContext context) {
        final LoginFormController formController = Get.put(LoginFormController()); 
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
                                    children: [
                                        const SizedBox(height: 20),
                                        TextFormField(
                                            controller: controller.emailCntrll,
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
                                            controller: controller.passwordCntrll,
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
        
                const SizedBox(height: 30),
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
                        if (!controller.emailCntrll.text.isNotEmpty || !formController.isEmailValid.value) {
                            Get.snackbar('Error', 'Ingrese un email valido.', backgroundColor: AppColor.blueDark, colorText: AppColor.blueLight);
                        // } else if (!controller.passwordCntrll.text.isNotEmpty || (!formController.isPasswordValid.value)) {
                        //     Get.snackbar('Error', 'Ingrese el password válido mayor a 6 caracteres.', backgroundColor: AppColor.blueDark, colorText: AppColor.blueLight);
                        } else {
                            controller.loginWithEmail();    
                        }
                        
                    },
                    child: Container(
                        height: 50.0,
                        width: 200.0,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100.0)),
                        child: Center(child: Text('Aceptar', style: TextStyle(color: AppColor.yellow))),
                    ),
                ),
            ],
        );
    }
}
