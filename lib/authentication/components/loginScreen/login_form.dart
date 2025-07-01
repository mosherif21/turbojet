import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../general/common_widgets/regular_elevated_button.dart';
import '../../../../general/common_widgets/regular_text_button.dart';
import '../../../../general/common_widgets/text_form_field.dart';
import '../../../../general/common_widgets/text_form_field_passwords.dart';
import '../../../../general/validation_functions.dart';
import '../../../general/constants.dart';
import '../../../general/general_functions.dart';
import '../../controllers/login_controller.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormFieldRegular(
            labelText: 'E-Mail',
            hintText: 'Enter your E-Mail',
            prefixIconData: Icons.email_outlined,
            textController: controller.emailTextController,
            inputType: InputType.email,
            editable: true,
            textInputAction: TextInputAction.next,
            validationFunction: validateEmail,
          ),
          const SizedBox(height: 10),
          TextFormFieldPassword(
            labelText: 'Password',
            textController: controller.passwordTextController,
            textInputAction: TextInputAction.done,
            onSubmitted: () => controller.loginUser(),
            validationFunction: validatePassword,
          ),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerRight,
            child: RegularTextButton(
              buttonText: 'Forgot Password?',
              onPressed: () => getToResetPasswordScreen(),
            ),
          ),
          const SizedBox(height: 6),
          RegularElevatedButton(
            enabled: true,
            buttonText: 'LOGIN',
            onPressed: () => controller.loginUser(),
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
