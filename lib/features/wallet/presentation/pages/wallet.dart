import 'package:clearance_processing_system/core/helpers/helpers_functions.dart';
import 'package:clearance_processing_system/core/utils/strings.dart';
import 'package:clearance_processing_system/general_widgets/UCPSScaffold.dart';
import 'package:clearance_processing_system/general_widgets/shrink_button.dart';
import 'package:clearance_processing_system/general_widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utils/routes.dart';
import '../notifiers/wallet_notifier.dart';

class Wallet extends HookConsumerWidget {
  const Wallet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final walletNotifier = ref.watch(walletNotifierProvider);

    return UCPSScaffold(
      title: AppStrings.wallet,
      showLeadingBtn: false,
      child: SizedBox(
        width: Helpers.width(context),
        child: Wrap(
          children: [
            ShrinkButton(
              hasBorder: true,
              text: 'Fund wallet',
              icon: const Icon(Icons.add),
              hasIcon: true,
              onTap: () => walletNotifier.fundWallet(context),
            ),
            const Spacing.largeWidth(),
            const Spacing.largeHeight(),

            ShrinkButton(
              hasBorder: true,
              text: 'Transaction history',
              icon: const Icon(Icons.people_alt_outlined),
              hasIcon: true,
              onTap: () => Navigator.of(context).pushNamed(Routes.transactionHistory),
            ),
          ],
        ),
      ),
    );
  }
}