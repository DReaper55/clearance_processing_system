
import 'package:clearance_processing_system/features/homepage/presentation/pages/homepage.dart';
import 'package:clearance_processing_system/features/homepage/presentation/pages/side_nav_pages.dart';
import 'package:clearance_processing_system/features/login/presentation/pages/login.dart';
import 'package:clearance_processing_system/features/register/presentation/pages/register.dart';
import 'package:flutter/material.dart';

class Routes {
  static const first = '/';
  static const onboard = '/onboardingView';
  static const login = '/login';
  static const register = '/register';
  static const forgot = '/forgotPass';
  static const changePassword = '/changePassword';
  static const homepage = '/homepage';

  static const sideNavPages = '/sideNavPages';
  static const dashboard = '/dashboard';
  static const studentManagement = '/studentManagement';
  static const userManagement = '/userManagement';
  static const feeManagement = '/feeManagement';
  static const myProfile = '/myProfile';
  static const wallet = '/wallet';
  static const clearance = '/clearance';


  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case register:
        return MaterialPageRoute(builder: (_) => const Register());
      case login:
        return MaterialPageRoute(builder: (_) => const Login());
      case forgot:
        return MaterialPageRoute(builder: (_) => const SizedBox());
      case changePassword:
        return MaterialPageRoute(builder: (_) => const SizedBox());
      case homepage:
        return MaterialPageRoute(builder: (_) => const Homepage());
      case first:
        return MaterialPageRoute(builder: (_) => const SizedBox());
      case dashboard:
        return MaterialPageRoute(builder: (_) => const SizedBox());
      case sideNavPages:
        return MaterialPageRoute(builder: (_) => const SideNavPages());
      case studentManagement:
        return MaterialPageRoute(builder: (_) => const SizedBox());
      case userManagement:
        return MaterialPageRoute(builder: (_) => const SizedBox());
      case feeManagement:
        return MaterialPageRoute(builder: (_) => const SizedBox());
      case myProfile:
        return MaterialPageRoute(builder: (_) => const SizedBox());
      case wallet:
        return MaterialPageRoute(builder: (_) => const SizedBox());
      case clearance:
        return MaterialPageRoute(builder: (_) => const SizedBox());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
