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
    return Scaffold(
      appBar: AppBar(
        leading: RegularBackButton(padding: 0),
        title: Text(
          "Session Metrics",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
        ),
        backgroundColor: Colors.white,
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
              childAspectRatio: AppInit.isWeb && !AppInit.isMobile ? 1.3 : 0.85,
              children: [
                buildGauge(
                  "Combustion In",
                  double.parse(sessionModel.combustionIn.toString()),
                  "°C",
                  max: 1024,
                ),
                buildGauge(
                  "Combustion Out",
                  double.parse(sessionModel.combustionOut.toString()),
                  "°C",
                  max: 1024,
                ),
                buildGauge(
                  "Exhaust",
                  double.parse(sessionModel.exhaust.toString()),
                  "°C",
                  max: 1024,
                ),
                buildGauge(
                  "Turbine",
                  double.parse(sessionModel.turbine.toString()),
                  "°C",
                  max: 1024,
                ),
                buildGauge(
                  "Oil In",
                  double.parse(sessionModel.oilIn.toString()),
                  "°C",
                  max: 125,
                  min: -55,
                ),
                buildGauge(
                  "Oil Out",
                  double.parse(sessionModel.oilOut.toString()),
                  "°C",
                  max: 125,
                  min: -55,
                ),
                buildGauge(
                  "Compression In",
                  double.parse(sessionModel.combustionIn.toString()),
                  "KPA",
                ),
                buildGauge(
                  "Compressor Out",
                  double.parse(sessionModel.compressorOut.toString()),
                  "KPA",
                ),
                buildGauge(
                  "RPM",
                  double.parse(sessionModel.rpm.toString()),
                  "Rev/min",
                  max: 6000,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGauge(
    String label,
    double value,
    String measuringUnit, {
    double max = 1000,
    double min = 0,
  }) {
    return Card(
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
              dimension: 180,
              minValue: min,
              maxValue: max,
              value: value,
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
                  value.toString(),
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
    );
  }
}
