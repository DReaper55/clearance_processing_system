import 'package:clearance_processing_system/core/utils/strings.dart';
import 'package:clearance_processing_system/general_widgets/UCPSScaffold.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ViewUsers extends HookConsumerWidget {
  const ViewUsers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return UCPSScaffold(
        title: AppStrings.viewRecords,
        child: const SizedBox(),
    );
  }
}