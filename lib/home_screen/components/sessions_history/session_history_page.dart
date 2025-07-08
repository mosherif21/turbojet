import 'package:flutter/material.dart';
import 'package:speedometer_chart/speedometer_chart.dart';
import 'package:turbo_jet/general/common_widgets/back_button.dart';
import 'package:turbo_jet/general/general_functions.dart';
import 'package:turbo_jet/home_screen/components/models.dart';

import '../../../general/app_init.dart';

class SessionHistoryPage extends StatelessWidget {
  const SessionHistoryPage({
    super.key,
    required this.sessionModel,
    required this.screenType,
  });
  final EngineSessionModel sessionModel;
  final GetScreenType screenType;

  @override
  Widget build(BuildContext context) {
    final screenWidth = getScreenWidth(context);

    double dynamicMin(double value, [double fallback = 0]) =>
        value < fallback ? value : fallback;
    double dynamicMax(double value, [double fallback = 1000]) =>
        value > fallback ? value : fallback;

    return Scaffold(
      appBar: AppBar(
        leading: RegularBackButton(padding: 0),
        title: Text(
          "Session Metrics",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
        ),
        backgroundColor: Colors.black, 
      ),
      backgroundColor: Colors.black,
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
                  sessionModel.combustionIn!.toDouble(),
                  "°C",
                  max: dynamicMax(sessionModel.combustionIn!.toDouble(), 1024),
                ),
                buildGauge(
                  screenWidth,
                  screenType.isPhone,
                  "Combustion Out",
                  sessionModel.combustionOut!.toDouble(),
                  "°C",
                  max: dynamicMax(sessionModel.combustionOut!.toDouble(), 1024),
                ),
                buildGauge(
                  screenWidth,
                  screenType.isPhone,
                  "Exhaust",
                  sessionModel.exhaust!.toDouble(),
                  "°C",
                  max: dynamicMax(sessionModel.exhaust!.toDouble(), 1024),
                ),
                buildGauge(
                  screenWidth,
                  screenType.isPhone,
                  "Turbine",
                  sessionModel.turbine!.toDouble(),
                  "°C",
                  max: dynamicMax(sessionModel.turbine!.toDouble(), 1024),
                ),
                buildGauge(
                  screenWidth,
                  screenType.isPhone,
                  "Oil In",
                  sessionModel.oilIn!.toDouble(),
                  "°C",
                  max: dynamicMax(sessionModel.oilIn!.toDouble(), 125),
                  min: dynamicMin(sessionModel.oilIn!.toDouble(), -55),
                ),
                buildGauge(
                  screenWidth,
                  screenType.isPhone,
                  "Oil Out",
                  sessionModel.oilOut!.toDouble(),
                  "°C",
                  max: dynamicMax(sessionModel.oilOut!.toDouble(), 125),
                  min: dynamicMin(sessionModel.oilOut!.toDouble(), -55),
                ),
                buildGauge(
                  screenWidth,
                  screenType.isPhone,
                  "RPM",
                  sessionModel.rpm!.toDouble(),
                  "Rev/min",
                  max: dynamicMax(sessionModel.rpm!.toDouble(), 10000),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGauge(
    double screenWidth,
    bool isPhone,
    String label,
    double value,
    String measuringUnit, {
    double max = 1000,
    double min = 0,
  }) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.zero,
      color: Color.fromRGBO(25, 25, 25, 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            SpeedometerChart(
              titleMargin: 20,
              dimension:
                  AppInit.isWeb && !AppInit.isMobile && !isPhone
                      ? screenWidth * 0.15
                      : screenWidth * 0.26,
              minValue: min,
              maxValue: max,
              value: value,
              graphColor: [
                Colors.white,
                Color.fromRGBO(206, 141, 2, 1),
                Colors.red,
              ],
              pointerColor: Colors.white,
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color.fromRGBO(206, 141, 2, 1),
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  measuringUnit,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    color: Colors.white,
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
