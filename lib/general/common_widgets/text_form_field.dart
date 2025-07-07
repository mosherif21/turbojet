import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';

class TextFormFieldRegular extends StatelessWidget {
  const TextFormFieldRegular({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.prefixIconData,
    required this.textController,
    required this.inputType,
    required this.editable,
    required this.textInputAction,
    this.inputFormatter,
    this.onSubmitted,
    this.validationFunction,
  });

  final String labelText;
  final String hintText;
  final IconData prefixIconData;
  final TextEditingController textController;
  final InputType inputType;
  final bool editable;
  final TextInputAction textInputAction;
  final TextInputFormatter? inputFormatter;
  final Function? onSubmitted;
  final String? Function(String?)? validationFunction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Theme(
        data: Theme.of(context).copyWith(
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.white,
            selectionColor: Colors.white24, // highlight color
            selectionHandleColor: Colors.white, // handle color
          ),
        ),
        child: TextFormField(
          style: const TextStyle(color: Colors.white),
          textInputAction: textInputAction,
          onFieldSubmitted:
              onSubmitted != null ? (enteredString) => onSubmitted!() : null,
          inputFormatters: inputFormatter != null ? [inputFormatter!] : [],
          enabled: editable,
          controller: textController,
          keyboardType:
              inputType == InputType.email
                  ? TextInputType.emailAddress
                  : inputType == InputType.numbers
                  ? TextInputType.number
                  : TextInputType.text,
          cursorColor: Colors.white,
          decoration: InputDecoration(
            labelStyle: const TextStyle(color: Colors.white),
            hintStyle: const TextStyle(color: Colors.white60),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(color: Colors.white),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              borderSide: BorderSide(color: Colors.white),
            ),
            prefixIcon: Icon(prefixIconData, color: Colors.white),
            labelText: labelText,
            hintText: hintText,
          ),
          validator: validationFunction,
        ),
      ),
    );
  }
}
