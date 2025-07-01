import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'connectivity/connectivity_controller.dart';
import 'general/app_init.dart';
import 'general/common_widgets/empty_scaffold.dart';

void main() async {
  await AppInit.initialize().whenComplete(() {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ConnectivityController());
    return SafeArea(
      top: false,
      child: GetMaterialApp(
        title: 'Turbo Charger',
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: NonScrollPhysics(),
            child: child!,
          );
        },
        fallbackLocale: const Locale('en', 'US'),
        home: const OrientationHandler(),
      ),
    );
  }
}

class OrientationHandler extends StatelessWidget {
  const OrientationHandler({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.shortestSide;

    if (screenWidth >= 600) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }

    return const EmptyScaffold();
  }
}

class NonScrollPhysics extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
