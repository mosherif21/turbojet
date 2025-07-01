import 'package:flutter/material.dart';

import '../../../general/app_init.dart';
import '../../../general/general_functions.dart';
import '../../connectivity/connectivity.dart';
import '../../general/common_widgets/regular_card.dart';
import '../../general/constants.dart';
import '../components/generalAuthComponents/authentication_form.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenType = GetScreenType(context);
    final screenHeight = getScreenHeight(context);
    ConnectivityChecker.checkConnection(displayAlert: true);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StretchingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  screenType.isPhone
                      ? const EdgeInsets.all(25)
                      : const EdgeInsets.only(
                        top: 15.0,
                        left: kDefaultPaddingSize,
                        right: 50,
                        bottom: kDefaultPaddingSize,
                      ),
              child:
                  screenType.isPhone
                      ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image(
                            image: const AssetImage(kLogoImage),
                            height:
                                AppInit.notWebMobile
                                    ? screenHeight * 0.39
                                    : screenHeight * 0.32,
                          ),
                          SizedBox(height: screenHeight * 0.05),
                          const AuthenticationForm(),
                          const SizedBox(height: 20),
                        ],
                      )
                      : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image(
                                image: const AssetImage(kLogoImage),
                                height: screenHeight * 0.5,
                              ),
                              Container(
                                constraints: const BoxConstraints(
                                  maxWidth: 500,
                                ),
                                child: const RegularCard(
                                  padding: 35,
                                  child: AuthenticationForm(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
            ),
          ),
        ),
      ),
    );
  }
}
