import 'package:get/get.dart';
import 'package:online_chat/bindings/chat_binding.dart';
import 'package:online_chat/bindings/complete_login_binding.dart';
import 'package:online_chat/bindings/home_binding.dart';
import 'package:online_chat/bindings/login_binding.dart';
import 'package:online_chat/bindings/signup_binding.dart';
import 'package:online_chat/bindings/splash_binding.dart';
import 'package:online_chat/bindings/to_profile_binding.dart';
import 'package:online_chat/routes/app_routes.dart';
import 'package:online_chat/ui/screens/chat/chat_screen.dart';
import 'package:online_chat/ui/screens/complete_login/complete_login_screen.dart';
import 'package:online_chat/ui/screens/home/home_screen.dart';
import 'package:online_chat/ui/screens/login/login_screen.dart';
import 'package:online_chat/ui/screens/signup/signup_screen.dart';
import 'package:online_chat/ui/screens/splash/splash_screen.dart';
import 'package:online_chat/ui/screens/to_profile/to_profile_screen.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.SIGNUP,
      page: () => SignupScreen(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => Splash(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.COMPLETE_LOGIN,
      page: () => CompleteLoginScreen(),
      binding: CompleteLoginBinding(),
    ),
    GetPage(
      name: AppRoutes.CHAT,
      page: () => ChatScreen(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: AppRoutes.PROFILE,
      page: () => ToProfileScreen(),
      binding: ToProfileBinding(),
    ),
  ];
}
