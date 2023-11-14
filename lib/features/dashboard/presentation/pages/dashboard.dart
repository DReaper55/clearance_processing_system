import 'package:clearance_processing_system/core/helpers/helpers_functions.dart';
import 'package:clearance_processing_system/core/utils/strings.dart';
import 'package:clearance_processing_system/general_widgets/UCPSScaffold.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../general_widgets/spacing.dart';
import '../widgets/infographic_card.dart';

class Dashboard extends HookConsumerWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return UCPSScaffold(
      title: AppStrings.dashboard,
      showLeadingBtn: false,
      child: SizedBox(
        width: Helpers.width(context),
        child: Column(
          children: [
            const Spacing.xLargeHeight(),
            Row(
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
            )
          ],
        ),
      ),
    );
  }
}