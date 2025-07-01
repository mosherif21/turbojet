import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:get/get.dart';
import 'package:speedometer_chart/speedometer_chart.dart';
import 'package:turbo_jet/general/app_init.dart';
import 'package:turbo_jet/general/general_functions.dart';
import 'package:turbo_jet/home_screen/controllers/home_screen_controller.dart';

class LiveSession extends StatelessWidget {
  const LiveSession({super.key});

  Widget buildGauge(
    double screenWidth,
    bool isPhone,
    String label,
    RxDouble value,
    String measuringUnit, {
    double max = 1000,
    double min = 0,
  }) {
    return Obx(
      () => Card(
        elevation: 4,
        margin: EdgeInsets.zero,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
              const SizedBox(height: 8),
              SpeedometerChart(
                titleMargin: 20,
                dimension:
                    AppInit.isWeb && !AppInit.isMobile && !isPhone
                        ? screenWidth * 0.13
                        : screenWidth * 0.26,
                minValue: min,
                maxValue: max,
                value: value.value.toDouble(),
                graphColor: [
                  Colors.grey.shade300,
                  Colors.grey.shade800,
                  Colors.black,
                ],
                pointerColor: Colors.black,
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    value.value.toString(),
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    measuringUnit,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = HomeScreenController.instance;
    final screenType = GetScreenType(context);
    final screenWidth = getScreenWidth(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Turbocharger Jet Engine",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: screenType.isPhone ? 2 : 4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: AppInit.isWeb && !AppInit.isMobile ? 1.3 : 0.9,
              children: [
                buildGauge(
                  screenWidth,
                  screenType.isPhone,
                  "Combustion In",
                  controller.combustionIn,
                  "°C",
                  max: 1024,
                ),
                buildGauge(
                  screenWidth,
                  screenType.isPhone,
                  "Combustion Out",
                  controller.combustionOut,
                  "°C",
                  max: 1024,
                ),
                buildGauge(
                  screenWidth,
                  screenType.isPhone,
                  "Exhaust",
                  controller.exhaust,
                  "°C",
                  max: 1024,
                ),
                buildGauge(
                  screenWidth,
                  screenType.isPhone,
                  "Turbine",
                  controller.turbine,
                  "°C",
                  max: 1024,
                ),
                buildGauge(
                  screenWidth,
                  screenType.isPhone,
                  "Oil In",
                  controller.oilIn,
                  "°C",
                  max: 125,
                  min: -55,
                ),
                buildGauge(
                  screenWidth,
                  screenType.isPhone,
                  "Oil Out",
                  controller.oilOut,
                  "°C",
                  max: 125,
                  min: -55,
                ),
                buildGauge(
                  screenWidth,
                  screenType.isPhone,
                  "RPM",
                  controller.rpm,
                  "Rev/min",
                  max: 6000,
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => AnimatedButton(
                    height: 50,
                    width: 150,
                    text:
                        controller.isSessionRunning.value
                            ? "Stop Engine"
                            : "Start Engine",
                    isReverse: true,
                    isSelected: controller.isStartButtonSelected.value,
                    selectedTextColor: Colors.white,
                    transitionType: TransitionType.LEFT_TO_RIGHT,
                    textStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
                    backgroundColor: Colors.white,
                    selectedBackgroundColor: Colors.black,
                    borderColor: Colors.black,
                    borderRadius: 50,
                    borderWidth: 2,
                    onPress: () {
                      controller.isStartButtonSelected.value = true;
                      if (controller.isSessionRunning.value) {
                        controller.stopEngine();
                      } else {
                        controller.startEngine();
                      }
                    },
                    onChanges: (value) {
                      Timer(Duration(seconds: 6), () {
                        bool engineRunning = controller.isSessionRunning.value;
                        bool shouldBeSelected = engineRunning == value;
                        if (!shouldBeSelected) {
                          controller.isStartButtonSelected.value = false;
                        }
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Obx(
                  () => AnimatedButton(
                    height: 50,
                    width: 150,
                    text: "Emergency Stop",
                    isReverse: false,
                    selectedTextColor: Colors.white,
                    transitionType: TransitionType.LEFT_TO_RIGHT,
                    textStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                    backgroundColor:
                        controller.isSessionRunning.value
                            ? Colors.red
                            : Colors.grey,
                    selectedBackgroundColor:
                        controller.isSessionRunning.value
                            ? Colors.red
                            : Colors.grey,
                    borderRadius: 50,
                    onPress:
                        controller.isSessionRunning.value
                            ? controller.emergencyStop
                            : () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
