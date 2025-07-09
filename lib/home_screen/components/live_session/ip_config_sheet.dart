import 'package:flutter/material.dart';
import 'package:turbo_jet/general/common_widgets/regular_elevated_button.dart';
import 'package:turbo_jet/general/common_widgets/text_form_field.dart';

import '../../../general/constants.dart';
import '../../../general/general_functions.dart';
import '../../controllers/home_screen_controller.dart';

class IpConfigBottomSheet extends StatelessWidget {
  final TextEditingController ipController = TextEditingController(
    text: HomeScreenController.instance.espIp.value,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
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
            labelText: "ESP IP (e.g., http://ller168.1.100)",
            textController: ipController,
            hintText: '',
            prefixIconData: Icons.save,
            inputType: InputType.url,
            editable: true,
            textInputAction: TextInputAction.done,
            onSubmitted: () {
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
            },
          ),
          SizedBox(height: 12),
          SizedBox(
            width: 140,
            child: RegularElevatedButton(
              buttonText: "Save",
              onPressed: () {
                final newIp = ipController.text.trim();
                final ipRegExp = RegExp(
                  r'^https?:\/\/(?:\d{1,3}\.){3}\d{1,3}$',
                );
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
              },
              enabled: true,
              color: Color.fromRGBO(206, 141, 2, 1),
            ),
          ),
        ],
      ),
    );
  }
}
