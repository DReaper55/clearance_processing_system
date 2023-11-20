import 'package:clearance_processing_system/core/helpers/extensions.dart';
import 'package:clearance_processing_system/core/helpers/helpers_functions.dart';
import 'package:clearance_processing_system/core/utils/dimensions.dart';
import 'package:clearance_processing_system/core/utils/strings.dart';
import 'package:clearance_processing_system/general_widgets/UCPSScaffold.dart';
import 'package:clearance_processing_system/general_widgets/shrink_button.dart';
import 'package:clearance_processing_system/general_widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../notifiers/clearance_notifier.dart';

class Clearance extends HookConsumerWidget {
  const Clearance({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clearanceNotifier = ref.watch(clearanceNotifierProvider);

    useEffect(() {
      Future.delayed(const Duration(milliseconds: 500), () {
        clearanceNotifier.getFeeCategories();
      });

      return () {};
    }, []);

    return UCPSScaffold(
      title: AppStrings.clearance,
      showLeadingBtn: false,
      child: SizedBox(
        width: Helpers.width(context),
        child: Column(
          children: [
            const Spacing.xLargeHeight(),
            Expanded(
              flex: 9,
              child: ListView.separated(
                itemBuilder: (ctx, i) {
                  final feeCat = clearanceNotifier.feeCategories.value[i];

                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.large,
                          vertical: Dimensions.medium),
                      child: ListTile(
                        title: Text(feeCat.feeEntity!.title!),
                        subtitle: Text(
                            '${feeCat.requirementEntities!.length} requirements'),
                        trailing: SizedBox(
                          width: Helpers.width(context) * .3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              OutlinedButton(
                                  style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.symmetric(
                                              vertical: Dimensions.medium, horizontal: Dimensions.mediumBig)),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0)))),
                                  onPressed: () => clearanceNotifier.navigateToRequirementPage(feeCat),
                                  child: const Text("View requirements")),
                              ElevatedButton(
                                  style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.symmetric(
                                              vertical: Dimensions.medium, horizontal: Dimensions.mediumBig)),
                                      backgroundColor:
                                          MaterialStateProperty.all(Colors.blue),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0)))),
                                  onPressed: () {},
                                  child: Text("Pay N${feeCat.feeEntity!.amount!.addComma()}")),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (ctx, i) => const Spacing.mediumHeight(),
                itemCount: clearanceNotifier.feeCategories.value.length,
              ),
            ),
            const Divider(),

            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total: N${clearanceNotifier.totalFee.value.toString().addComma()}'),
                  ShrinkButton(
                    onTap: (){},
                    text: 'Pay N${clearanceNotifier.totalFee.value.toString().addComma()}',
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
