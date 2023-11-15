
import 'package:clearance_processing_system/features/clearance/presentation/pages/clearance.dart';
import 'package:clearance_processing_system/features/dashboard/presentation/pages/dashboard.dart';
import 'package:clearance_processing_system/features/fee-management/presentation/pages/fee_management.dart';
import 'package:clearance_processing_system/features/fee-management/presentation/pages/post_fee.dart';
import 'package:clearance_processing_system/features/fee-management/presentation/pages/view_fees.dart';
import 'package:clearance_processing_system/features/homepage/presentation/pages/homepage.dart';
import 'package:clearance_processing_system/features/homepage/presentation/pages/side_nav_pages.dart';
import 'package:clearance_processing_system/features/login/presentation/pages/login.dart';
import 'package:clearance_processing_system/features/my-profile/presentation/pages/my_profile.dart';
import 'package:clearance_processing_system/features/register/presentation/pages/register.dart';
import 'package:clearance_processing_system/features/student-management/presentation/pages/register_student.dart';
import 'package:clearance_processing_system/features/student-management/presentation/pages/student_management.dart';
import 'package:clearance_processing_system/features/student-management/presentation/pages/view_students.dart';
import 'package:clearance_processing_system/features/user-management/presentation/pages/create_new_user.dart';
import 'package:clearance_processing_system/features/user-management/presentation/pages/user_management.dart';
import 'package:clearance_processing_system/features/user-management/presentation/pages/view_users.dart';
import 'package:clearance_processing_system/features/wallet/presentation/pages/wallet.dart';
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
  static const createStudent = '/createStudent';
  static const viewStudents = '/viewStudents';

  static const userManagement = '/userManagement';
  static const createNewUser = '/createNewUser';
  static const viewUsers = '/viewUsers';

  static const feeManagement = '/feeManagement';
  static const postAFee = '/postAFee';
  static const viewFees = '/viewFees';

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
        return MaterialPageRoute(builder: (_) => const Dashboard());
      case sideNavPages:
        return MaterialPageRoute(builder: (_) => const SideNavPages());
      case studentManagement:
        return MaterialPageRoute(builder: (_) => const StudentManagement());
      case createStudent:
        return MaterialPageRoute(builder: (_) => const RegisterStudent());
      case viewStudents:
        return MaterialPageRoute(builder: (_) => const ViewStudents());
      case userManagement:
        return MaterialPageRoute(builder: (_) => const UserManagement());
      case createNewUser:
        return MaterialPageRoute(builder: (_) => const CreateNewUser());
      case viewUsers:
        return MaterialPageRoute(builder: (_) => const ViewUsers());
      case feeManagement:
        return MaterialPageRoute(builder: (_) => const FeeManagement());
      case postAFee:
        return MaterialPageRoute(builder: (_) => const PostFee());
      case viewFees:
        return MaterialPageRoute(builder: (_) => const ViewFees());
      case myProfile:
        return MaterialPageRoute(builder: (_) => const MyProfile());
      case wallet:
        return MaterialPageRoute(builder: (_) => const Wallet());
      case clearance:
        return MaterialPageRoute(builder: (_) => const Clearance());
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
