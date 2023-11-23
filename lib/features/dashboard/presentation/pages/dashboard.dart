import 'package:clearance_processing_system/core/helpers/extensions.dart';
import 'package:clearance_processing_system/core/helpers/helpers_functions.dart';
import 'package:clearance_processing_system/core/utils/strings.dart';
import 'package:clearance_processing_system/general_widgets/UCPSScaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../general_widgets/spacing.dart';
import '../../../login/presentation/notifiers/login_notifier.dart';
import '../../../login/presentation/notifiers/user_notifier.dart';
import '../notifiers/dashboard_notifier.dart';
import '../widgets/infographic_card.dart';

class Dashboard extends HookConsumerWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isStudent = ref.watch(userIsStudentStateNotifier);

    final dashboardNotifier = ref.watch(dashboardNotifierProvider);

    useEffect(() {
      Future.delayed(const Duration(milliseconds: 500), () {
        dashboardNotifier.setData();
      });

      return () {};
    }, []);

    return UCPSScaffold(
      title: AppStrings.dashboard,
      showLeadingBtn: false,
      child: SizedBox(
        width: Helpers.width(context),
        child: Column(
          children: [
            const Spacing.xLargeHeight(),

            if(isStudent)
              _StudentDashboard(dashboardNotifier: dashboardNotifier,)
            else
              const _AdminDashboard(),
          ],
        ),
      ),
    );
  }
}

class _StudentDashboard extends StatelessWidget {
  final DashboardNotifier dashboardNotifier;

  const _StudentDashboard({super.key, required this.dashboardNotifier});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InfographicCard(
          bodyText: '0',
          titleText: 'Clearance processed',
        ),
        InfographicCard(
          bodyText: 'N ${dashboardNotifier.cashInWallet.value.addComma()}',
          titleText: 'Wallet balance',
        ),
      ],
    );
  }
}

class _AdminDashboard extends StatelessWidget {
  const _AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InfographicCard(
          bodyText: '0',
          titleText: 'Cleared students',
        ),
        InfographicCard(
          bodyText: '0',
          titleText: 'Total revenue',
        ),
      ],
    );
  }
}

