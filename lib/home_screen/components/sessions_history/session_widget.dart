import 'package:flutter/material.dart';

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
