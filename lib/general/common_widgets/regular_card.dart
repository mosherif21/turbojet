import 'package:flutter/material.dart';

class RegularCard extends StatelessWidget {
  const RegularCard({super.key, required this.child, required this.padding});
  final Widget child;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade900, //New
            blurRadius: 10.0,
          ),
        ],
        color: Color.fromRGBO(25, 25, 25, 1),
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      ),
      child: Center(child: child),
    );
  }
}
