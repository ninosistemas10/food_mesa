import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';

class RegisterFormController extends GetxController {
    RxBool isNombre           = true.obs;  
    RxBool isEmailValid       = true.obs;
    RxBool isPasswordValid    = true.obs;

    RxString nombre           = ''.obs;
    RxString email            = ''.obs;
    RxString password         = ''.obs;


    void validateNombre(String  value) {
        isNombre.value = value.isNotEmpty;
    }

    void validateEmail(String value) {
        isEmailValid.value = EmailValidator.validate(value);
    }

    void validatePassword(String value) {
        isPasswordValid.value = value.isNotEmpty && value.length >= 6;
    }
}
