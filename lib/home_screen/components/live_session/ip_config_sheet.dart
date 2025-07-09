import 'package:flutter/material.dart';
import 'package:turbo_jet/general/common_widgets/regular_elevated_button.dart';
import 'package:turbo_jet/general/common_widgets/text_form_field.dart';

import '../../../general/constants.dart';
import '../../../general/general_functions.dart';
import '../../controllers/home_screen_controller.dart';

class IpConfigBottomSheet extends StatefulWidget {
  const IpConfigBottomSheet({super.key});

  @override
  State<IpConfigBottomSheet> createState() => _IpConfigBottomSheetState();
}

class _IpConfigBottomSheetState extends State<IpConfigBottomSheet> {
  late final TextEditingController ipController;

  @override
  void initState() {
    super.initState();
    ipController = TextEditingController(
      text: HomeScreenController.instance.espIp.value,
    );
  }

  @override
  void dispose() {
    ipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom, // ✅ Handles keyboard
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Set ESP32 IP Address",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 12),
            TextFormFieldRegular(
              labelText: "ESP IP (e.g., http://192.168.1.100)",
              textController: ipController,
              hintText: '',
              prefixIconData: Icons.save,
              inputType: InputType.url,
              editable: true,
              textInputAction: TextInputAction.done,
              onSubmitted: _submit,
            ),
            SizedBox(height: 12),
            SizedBox(
              width: 140,
              child: RegularElevatedButton(
                buttonText: "Save",
                onPressed: _submit,
                enabled: true,
                color: Color.fromRGBO(206, 141, 2, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() {
    final newIp = ipController.text.trim();
    final ipRegExp = RegExp(r'^https?:\/\/(?:\d{1,3}\.){3}\d{1,3}$');

    if (ipRegExp.hasMatch(newIp)) {
      HomeScreenController.instance.updateEspIp(newIp);
      Navigator.pop(context);
      showSnackBar(
        text: "ESP IP updated to $newIp",
        snackBarType: SnackBarType.success,
      );
    } else {
      showSnackBar(
        text: "Please enter a valid IP like http://192.168.1.100",
        snackBarType: SnackBarType.error,
      );
    }
  }
}
