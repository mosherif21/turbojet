import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../general/general_functions.dart';
import '../../auth_repo/authentication_repository.dart';
import '../../general/constants.dart';

class PasswordResetLinkController extends GetxController {
  static PasswordResetLinkController get instance => Get.find();
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void onReady() {
    final user = AuthenticationRepository.instance.fireUser.value;
    if (user != null) {
      if (user.email != null) {
        emailController.text = user.email!;
      }
    }
    super.onReady();
  }

  Future<void> resetPassword() async {
    if (formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      Get.back();
      final email = emailController.text.trim();
      showLoadingScreen();
      String returnMessage =
          email.isEmpty
              ? 'No Email entered'
              : !email.isEmail
              ? 'Email entered is invalid'
              : await AuthenticationRepository.instance.sendResetPasswordLink(
                email: email,
              );

      if (returnMessage == 'emailSent') {
        Get.back();
        showSnackBar(
          text: 'Reset password email sent successfully',
          snackBarType: SnackBarType.success,
        );
      } else {
        showSnackBar(text: returnMessage, snackBarType: SnackBarType.error);
      }
      hideLoadingScreen();
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
