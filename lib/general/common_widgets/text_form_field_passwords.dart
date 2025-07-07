import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFormFieldPassword extends StatelessWidget {
  const TextFormFieldPassword({
    super.key,
    required this.labelText,
    required this.textController,
    required this.textInputAction,
    this.onSubmitted,
    required this.validationFunction,
  });

  final String labelText;
  final TextEditingController textController;
  final TextInputAction textInputAction;
  final Function? onSubmitted;
  final String? Function(String?)? validationFunction;

  @override
  Widget build(BuildContext context) {
    RxBool passwordHide = true.obs;
    return Obx(
      () => Theme(
        data: Theme.of(context).copyWith(
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.white,
            selectionColor: Colors.white24, // highlight color
            selectionHandleColor: Colors.white, // handle drag dots color
          ),
        ),
        child: TextFormField(
          textInputAction: textInputAction,
          onFieldSubmitted:
              onSubmitted != null ? (enteredString) => onSubmitted!() : null,
          obscureText: passwordHide.value,
          controller: textController,
          cursorColor: Colors.white,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelStyle: const TextStyle(color: Colors.white),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(color: Colors.white),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              borderSide: BorderSide(color: Colors.white),
            ),
            prefixIcon: const Icon(Icons.lock_outlined, color: Colors.white),
            labelText: labelText,
            hintText: 'Enter your Password',
            hintStyle: const TextStyle(color: Colors.white60),
            suffixIcon: IconButton(
              onPressed: () => passwordHide.value = !passwordHide.value,
              icon: Icon(
                passwordHide.value
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Colors.white,
              ),
            ),
          ),
          validator: validationFunction,
        ),
      ),
    );
  }
}
