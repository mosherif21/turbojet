const double kDefaultPaddingSize = 30.0;
const double kButtonHeight = 20.0;

//assets
const String kBrandedLogoImage = "assets/images/branded_logo.jpg";
const String kLogoNoBackImage = "assets/images/logo_no_back.png";
const String kBrandedLogoNoBackImage = "assets/images/branded_logo_no_back.png";

//--Lottie assets
const kNoInternetSwitchAnim = "assets/lottie_animations/noInternetAnim.json";
const String kEmailVerificationAnim =
    "assets/lottie_animations/email_verification.json";
const String kPasswordResetAnim =
    "assets/lottie_animations/password_reset.json";
const String kDeleteAnim = "assets/lottie_animations/delete.json";
const String kLoadingRocket = "assets/lottie_animations/rocket_animation.json";
const String kNoSessions = "assets/lottie_animations/noSessions.json";
const String kStartupSounds = "assets/sounds/startup.mp3";

enum AuthType { emailLogin, emailRegister }

enum Language { english, arabic }

enum InputType { email, phone, text, numbers }

enum ScreenSize { small, medium, large }

enum FunctionStatus { success, failure }

enum SnackBarType { success, error, info, warning }
