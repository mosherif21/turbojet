import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:turbo_jet/general/validation_functions.dart';

import 'common_widgets/single_entry_screen.dart';
import 'constants.dart';

double getScreenHeight(BuildContext context) =>
    MediaQuery.of(context).size.height;

double getScreenWidth(BuildContext context) =>
    MediaQuery.of(context).size.width;

void showLoadingScreen() {
  final height = Get.context != null ? Get.context!.height : 200;
  Get.dialog(
    AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: PopScope(
        canPop: false,
        child: Lottie.asset(kLoadingRocket, height: height * 0.3),
      ),
    ),
    barrierDismissible: false,
  );
}

void hideLoadingScreen() {
  Get.back();
}

void getToResetPasswordScreen() {
  Get.to(
    () => SingleEntryScreen(
      title: 'Enter your E-Mail to get the password reset link',
      prefixIconData: Icons.email_outlined,
      lottieAssetAnim: kEmailVerificationAnim,
      textFormTitle: 'E-Mail',
      textFormHint: 'Enter your E-Mail',
      buttonTitle: 'Confirm',
      inputType: InputType.email,
      validationFunction: validateEmail,
    ),
    transition: getPageTransition(),
  );
}

Transition getPageTransition() {
  final context = Get.context;
  if (context != null) {
    final screenType = GetScreenType(context);
    return !screenType.isPhone ? Transition.downToUp : Transition.rightToLeft;
  }

  return Transition.rightToLeft;
}

void showSnackBar({required String text, required SnackBarType snackBarType}) {
  if (Get.overlayContext != null) {
    late final AnimatedSnackBar snackBar;
    switch (snackBarType) {
      case SnackBarType.success:
        snackBar = AnimatedSnackBar.rectangle(
          duration: const Duration(seconds: 3),
          desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
          'Success',
          text,
          type: AnimatedSnackBarType.success,
          brightness: Brightness.light,
        );
        break;
      case SnackBarType.error:
        snackBar = AnimatedSnackBar.rectangle(
          duration: const Duration(seconds: 3),
          desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
          'Error',
          text,
          type: AnimatedSnackBarType.error,
          brightness: Brightness.light,
        );
        break;
      case SnackBarType.warning:
        snackBar = AnimatedSnackBar.rectangle(
          duration: const Duration(seconds: 3),
          desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
          'Warning',
          text,
          type: AnimatedSnackBarType.warning,
          brightness: Brightness.light,
        );
        break;
      case SnackBarType.info:
        snackBar = AnimatedSnackBar.rectangle(
          duration: const Duration(seconds: 3),
          desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
          'Info',
          text,
          type: AnimatedSnackBarType.info,
          brightness: Brightness.light,
        );
        break;
    }
    snackBar.show(Get.overlayContext!);
  }
}

class GetScreenType {
  final BuildContext context;

  GetScreenType(this.context);

  bool get isPhone => MediaQuery.of(context).size.width < 900;

  bool get isTablet =>
      MediaQuery.of(context).size.width >= 900 &&
      MediaQuery.of(context).size.width < 1200;

  bool get isDesktop => MediaQuery.of(context).size.width >= 1200;
}
