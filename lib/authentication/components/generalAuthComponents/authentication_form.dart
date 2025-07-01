import 'package:flutter/material.dart';

import '../loginScreen/login_form.dart';

class AuthenticationForm extends StatelessWidget {
  const AuthenticationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: LoginForm());
  }
}
