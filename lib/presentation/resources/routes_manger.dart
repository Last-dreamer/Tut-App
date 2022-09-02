import 'package:flutter/material.dart';
import 'package:tut_app/presentation/forgot_password/forgot_password_screen.dart';
import 'package:tut_app/presentation/login/login_screen.dart';
import 'package:tut_app/presentation/main/main_screen.dart';
import 'package:tut_app/presentation/onBoarding/onboarding_screen.dart';
import 'package:tut_app/presentation/register/register_screen.dart';
import 'package:tut_app/presentation/resources/string_manager.dart';
import 'package:tut_app/presentation/splash/splash_screen.dart';
import 'package:tut_app/presentation/store_details/store_details.dart';

import '../../app/di.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginroute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(
            builder: (context) => const OnBoardingScreen());
      case Routes.loginroute:
        return MaterialPageRoute(builder: (context) {
          initLoginModule();
          return const LoginScreen();
        });
      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(builder: (context) => const RegisterScreen());
      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(
            builder: (context) => const ForgotPasswordScreen());
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (context) => const MainScreen());
      case Routes.storeDetailsRoute:
        return MaterialPageRoute(builder: (context) => const StoreDetails());

      default:
        return errorRoute();
    }
  }

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(
        builder: (context) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.notRouteFound),
              ),
              body: const Center(
                child: Text("No Route Found.....!"),
              ),
            ));
  }
}
