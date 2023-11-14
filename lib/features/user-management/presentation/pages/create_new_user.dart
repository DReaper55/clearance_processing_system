import 'package:clearance_processing_system/core/utils/strings.dart';
import 'package:clearance_processing_system/general_widgets/UCPSScaffold.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateNewUser extends HookConsumerWidget {
  const CreateNewUser({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return UCPSScaffold(
      title: AppStrings.createNewUser,
      child: const SizedBox(),
    );
  }
}