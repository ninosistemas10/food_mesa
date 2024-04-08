import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';

class LoginFormController extends GetxController {
    RxBool isEmailValid = true.obs;
    RxBool isPasswordValid = true.obs;

    RxString email = ''.obs;
    RxString password = ''.obs;

    void validateEmail(String value) {
        isEmailValid.value = EmailValidator.validate(value);
    }

    void validatePassword(String value) {
        isPasswordValid.value = value.isNotEmpty && value.length >= 6;
    }
}
