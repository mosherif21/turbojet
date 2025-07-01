import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:turbo_jet/home_screen/screens/home_screen.dart';

import '../auth_repo/authentication_repository.dart';
import '../authentication/screens/auth_screen.dart';
import '../firebase_options.dart';
import 'constants.dart';
import 'error_widgets/no_internet_error_widget.dart';

class AppInit {
  static bool notWebMobile = false;
  static bool isMobile = false;
  static bool isWeb = false;
  static bool isAndroid = false;
  static bool isIos = false;
  static bool isWindows = false;
  static bool isMacOS = false;
  static bool webMobile = false;
  static bool isInitialised = false;
  static bool isConstantsInitialised = false;
  static bool splashRemoved = false;
  static final player = AudioPlayer();
  static final currentAuthType = AuthType.emailLogin.obs;

  static Future<void> initializeConstants() async {
    if (!isConstantsInitialised) {
      isWeb = kIsWeb;
      notWebMobile =
          isWeb &&
          !(defaultTargetPlatform == TargetPlatform.iOS ||
              defaultTargetPlatform == TargetPlatform.android);

      webMobile =
          isWeb &&
          (defaultTargetPlatform == TargetPlatform.iOS ||
              defaultTargetPlatform == TargetPlatform.android);

      if (defaultTargetPlatform == TargetPlatform.android && !isWeb) {
        isAndroid = true;
      }
      if (defaultTargetPlatform == TargetPlatform.iOS && !isWeb) {
        isIos = true;
      }
      if (defaultTargetPlatform == TargetPlatform.windows && !isWeb) {
        isWindows = true;
      }
      if (defaultTargetPlatform == TargetPlatform.macOS && !isWeb) {
        isMacOS = true;
      }
      if (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS && !isWeb) {
        isMobile = true;
      }

      isConstantsInitialised = true;
    }
  }

  static Future<void> initializeDatabase() async {
    if (!isInitialised) {
      isInitialised = true;
      await initializeFireBaseApp();

      if (kDebugMode) {
        print('firebase app initialized');
      }
      FirebaseFirestore.instance.settings = const Settings(
        persistenceEnabled: false,
      );

      Get.put(AuthenticationRepository(), permanent: true);
    }
  }

  static Future<void> initialize() async {
    final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    await initializeConstants();
  }

  static Future<void> internetInitialize() async {
    if (!isInitialised) {
      AppInit.initializeDatabase().whenComplete(() async {
        await goToInitPage();
      });
    }
  }

  static Future<void> noInternetInitializeCheck() async {
    if (!isInitialised) {
      removeSplashScreen();

      Get.offAll(() => const NotInternetErrorWidget());
    }
  }

  static Future<void> goToInitPage() async {
    final authRepo = AuthenticationRepository.instance;
    removeSplashScreen();
    if (authRepo.isUserLoggedIn) {
      Get.offAll(
        () => const HomeScreen(),
        routeName: 'MainScreen',
        transition: isWeb ? Transition.noTransition : Transition.circularReveal,
      );
    } else {
      Get.offAll(
        () => const AuthenticationScreen(),
        transition: isWeb ? Transition.noTransition : Transition.circularReveal,
      );
    }
  }

  static void removeSplashScreen() {
    if (!splashRemoved) {
      FlutterNativeSplash.remove();
      splashRemoved = true;
    }
  }
}
