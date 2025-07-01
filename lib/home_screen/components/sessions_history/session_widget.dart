import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:turbo_jet/general/constants.dart';

import '../../../general/general_functions.dart';

class SessionWidget extends StatelessWidget {
  const SessionWidget({
    super.key,
    required this.sessionDate,
    required this.onTap,
    required this.stoppingStatus,
  });
  final String sessionDate;
  final Function onTap;
  final String stoppingStatus;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 5)],
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        child: InkWell(
          onTap: () => onTap(),
          borderRadius: BorderRadius.circular(10),
          splashFactory: InkSparkle.splashFactory,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Status: ${stoppingStatus == "stopped" ? "Normally stopped" : "Emergency stopped"}",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  sessionDate,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoadingSessionWidget extends StatelessWidget {
  const LoadingSessionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 5)],
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      width: 200,
      height: 160,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 24,
              width: 180,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              height: 18,
              width: 140,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NoSessionsWidget extends StatelessWidget {
  const NoSessionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = getScreenHeight(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(
          kNoSessions,
          fit: BoxFit.contain,
          height: screenHeight * 0.5,
        ),
        AutoSizeText(
          'No Sessions',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
        ),
        const SizedBox(height: 5.0),
        AutoSizeText(
          'There are no sessions at this date',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 2,
        ),
      ],
    );
  }
}
