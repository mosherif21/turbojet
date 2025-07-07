import 'package:flutter/material.dart';
import 'package:turbo_jet/authentication/components/loginScreen/login_form.dart';

import '../../../general/app_init.dart';
import '../../../general/general_functions.dart';
import '../../connectivity/connectivity.dart';
import '../../general/common_widgets/regular_card.dart';
import '../../general/constants.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenType = GetScreenType(context);
    final screenHeight = getScreenHeight(context);
    ConnectivityChecker.checkConnection(displayAlert: true);
    return Scaffold(
      backgroundColor: Colors.black,
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
                            image: const AssetImage(kLogoNoBackImage),
                            height:
                                AppInit.notWebMobile
                                    ? screenHeight * 0.39
                                    : screenHeight * 0.32,
                          ),
                          SizedBox(height: screenHeight * 0.05),
                          const LoginForm(),
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
                                image: const AssetImage(kLogoNoBackImage),
                                height: screenHeight * 0.5,
                              ),
                              Container(
                                constraints: const BoxConstraints(
                                  maxWidth: 500,
                                ),
                                child: const RegularCard(
                                  padding: 35,
                                  child: LoginForm(),
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
