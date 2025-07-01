import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../general/general_functions.dart';
import '../../auth_repo/authentication_repository.dart';
import '../../general/constants.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();

  static LoginController get instance => Get.find();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  Future<void> loginUser() async {
    if (formKey.currentState!.validate()) {
      final email = emailTextController.text;
      final password = passwordTextController.text;
      String returnMessage = '';
      FocusManager.instance.primaryFocus?.unfocus();
      showLoadingScreen();
      if (email.isEmail && password.length >= 8) {
        returnMessage = await AuthenticationRepository.instance
            .signInWithEmailAndPassword(email, password);
      } else if (email.isEmpty || password.isEmpty) {
        returnMessage = 'Fields can\'t be empty';
      } else if (password.length < 8) {
        returnMessage = 'Password can\'t be less than 8 characters';
      } else {
        returnMessage = 'Email entered is invalid';
      }
      if (returnMessage != 'success') {
        hideLoadingScreen();
        showSnackBar(text: returnMessage, snackBarType: SnackBarType.error);
      }
    }
  }

  @override
  void onClose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.onClose();
  }
}
