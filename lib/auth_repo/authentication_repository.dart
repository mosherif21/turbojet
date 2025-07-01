import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../general/app_init.dart';
import '../general/constants.dart';
import 'exception_errors/password_reset_exceptions.dart';
import 'exception_errors/signin_email_password_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> fireUser;
  bool isUserLoggedIn = false;
  bool isUserRegistered = false;
  String verificationId = '';
  final userEmail = ''.obs;
  @override
  void onInit() async {
    fireUser = Rx<User?>(_auth.currentUser);
    if (fireUser.value != null) {
      isUserLoggedIn = true;
    }
    fireUser.bindStream(_auth.userChanges());
    fireUser.listen((user) async {
      if (user != null) {
        if (user.email != null) {
          userEmail.value = user.email!;
        }
      }
    });

    super.onInit();
  }

  Future<String> resetPassword(String oldPassword, String password) async {
    try {
      final credential = EmailAuthProvider.credential(
        email: userEmail.value,
        password: oldPassword,
      );
      await fireUser.value!.reauthenticateWithCredential(credential);
      await fireUser.value!.updatePassword(password);
      return 'success';
    } on FirebaseAuthException catch (e) {
      final ex = SignInWithEmailAndPasswordFailure.code(e.code);
      if (kDebugMode) {
        print('FIREBASE AUTH EXCEPTION : ${e.toString()}');
      }
      return ex.errorMessage;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return 'An unknown error occurred. Try again';
  }

  // Future<String> createUserWithEmailAndPassword(
  //   String email,
  //   String password,
  // ) async {
  //   try {
  //     await _auth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     if (fireUser.value != null) {
  //       AppInit.currentAuthType.value = AuthType.emailLogin;
  //       isUserLoggedIn = true;
  //       AppInit.goToInitPage();
  //       return 'success';
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
  //     if (kDebugMode) {
  //       AppInit.logger.e('FIREBASE AUTH EXCEPTION : ${ex.errorMessage}');
  //     }
  //     return ex.errorMessage;
  //   } catch (e) {
  //     if (kDebugMode) {
  //       AppInit.logger.e(e.toString());
  //     }
  //   }
  //   return 'unknownError'.tr;
  // }

  Future<String> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (fireUser.value != null) {
        AppInit.currentAuthType.value = AuthType.emailLogin;
        isUserLoggedIn = true;
        AppInit.goToInitPage();
        return 'success';
      }
    } on FirebaseAuthException catch (e) {
      final ex = SignInWithEmailAndPasswordFailure.code(e.code);
      if (kDebugMode) {
        print('FIREBASE AUTH EXCEPTION : ${ex.errorMessage}');
      }

      return ex.errorMessage;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return 'An unknown error occurred. Try again';
  }

  // Future<String> changeEmail(String newEmail, String password) async {
  //   try {
  //     final credential = EmailAuthProvider.credential(
  //       email: fireUser.value!.email!,
  //       password: password,
  //     );
  //     await fireUser.value!.reauthenticateWithCredential(credential);
  //     await fireUser.value!.verifyBeforeUpdateEmail(newEmail);
  //     return 'success';
  //   } on FirebaseAuthException catch (ex) {
  //     if (kDebugMode) {
  //       print('FIREBASE AUTH EXCEPTION : ${ex.toString()}');
  //     }
  //     if (ex.code == 'invalid-email') {
  //       return 'invalidEmailEntered'.tr;
  //     } else if (ex.code == 'email-already-in-use') {
  //       return 'emailAlreadyExists'.tr;
  //     } else if (ex.code == 'missing-email') {
  //       return 'missingEmail'.tr;
  //     } else if (ex.code == 'user-not-found') {
  //       return 'noRegisteredEmail'.tr;
  //     } else if (ex.code == 'invalid-credential') {
  //       return 'wrongCredentials'.tr;
  //     } else if (ex.code == 'requires-recent-login') {
  //       return 'requireRecentLoginError'.tr;
  //     }
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e.toString());
  //     }
  //   }
  //   return 'unknownError'.tr;
  // }

  Future<String> sendResetPasswordLink({required String email}) async {
    String returnMessage = 'An unknown error occurred. Try again';
    try {
      await _auth.setLanguageCode('en');
      await _auth
          .sendPasswordResetEmail(email: email)
          .whenComplete(() => returnMessage = 'emailSent');
      await _auth.setLanguageCode('en');
    } on FirebaseAuthException catch (e) {
      final ex = ResetPasswordFailure.code(e.code);

      if (kDebugMode) {
        print('FIREBASE AUTH EXCEPTION : ${ex.errorMessage}');
      }
      return ex.errorMessage;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return returnMessage;
  }

  Future<void> logoutAuth() async {
    await _auth.signOut();
  }

  Future<FunctionStatus> logoutAuthUser() async {
    try {
      await logoutAuth();

      isUserRegistered = false;
      isUserLoggedIn = false;
      verificationId = '';

      return FunctionStatus.success;
    } on FirebaseAuthException catch (ex) {
      if (kDebugMode) {
        print(ex.code);
      }
    } catch (e) {
      if (kDebugMode) e.printError();
    }
    return FunctionStatus.failure;
  }
}
