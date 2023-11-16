import 'package:clearance_processing_system/core/helpers/helpers_functions.dart';
import 'package:clearance_processing_system/core/utils/colors.dart';
import 'package:clearance_processing_system/core/utils/strings.dart';
import 'package:clearance_processing_system/core/utils/text_styles.dart';
import 'package:clearance_processing_system/core/utils/validations.dart';
import 'package:clearance_processing_system/general_widgets/UCPSScaffold.dart';
import 'package:clearance_processing_system/general_widgets/app_loader.dart';
import 'package:clearance_processing_system/general_widgets/custom-widgets/dropdown_field.dart';
import 'package:clearance_processing_system/general_widgets/shrink_button.dart';
import 'package:clearance_processing_system/general_widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utils/routes.dart';
import '../notifiers/fee_notifier.dart';


class PostFee extends HookConsumerWidget {
  const PostFee({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createNewFeeNotifier = ref.watch(createNewFeeNotifierProvider);

    useEffect(() {
      Future.delayed(const Duration(milliseconds: 500), () {
        createNewFeeNotifier.setData();
      });

      return () {};
    }, []);

    return UCPSScaffold(
      title: AppStrings.postAFee,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width: Helpers.width(context) * .5,
        height: Helpers.height(context) * .9,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Spacing.bigHeight(),
              TextFormField(
                controller: createNewFeeNotifier.titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const Spacing.bigHeight(),

              // ................................................
              // Amount
              // ................................................
              _LoadingTextField(
                hintText: 'Amount',
                controller: createNewFeeNotifier.amountController,
                enabled: true,
                // data: createNewFeeNotifier.onData,
                isLoading: createNewFeeNotifier.isLoadingAccNum,
              ),
              const Spacing.largeHeight(),
              // ................................................
              // Account Number
              // ................................................
              _LoadingTextField(
                hintText: LabelStrings.accountNumber,
                controller: createNewFeeNotifier.accountNumberController,
                enabled: true,
                onChanged: createNewFeeNotifier.onAccNumberChanged,
                // data: createNewFeeNotifier.onData,
                isLoading: createNewFeeNotifier.isLoadingAccNum,
              ),
              const Spacing.largeHeight(),
              // ................................................
              // Bank Name
              // ................................................
              _LoadingTextField(
                hintText: LabelStrings.bankName,
                controller: createNewFeeNotifier.bankNameController,
                enabled: true,
                onTap: () => createNewFeeNotifier.onBankLoadTap(context),
                // data: createNewFeeNotifier.onData,
                isLoading: createNewFeeNotifier.isLoadingAccNum,
              ),
              const Spacing.largeHeight(),
              // ................................................
              // Account name
              // ................................................
              _LoadingTextField(
                hintText: LabelStrings.accountName,
                controller: createNewFeeNotifier.accountNameController,
                enabled: false,
                // data: createNewFeeNotifier.onData,
                isLoading: createNewFeeNotifier.isLoadingAccNum,
              ),

              const Spacing.xLargeHeight(),
              // ................................................
              // List of selected departments
              // ................................................
              if(createNewFeeNotifier.selectedDepartments.value.isNotEmpty)
                SizedBox(
                  width: Helpers.width(context),
                  height: 60.0,
                  child: ListView.separated(
                      itemBuilder: (ctx, i){
                        final department = createNewFeeNotifier.selectedDepartments.value[i];

                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(department!.values.first),
                                const Spacing.smallWidth(),

                                IconButton(onPressed: () => createNewFeeNotifier.removeItem(department), icon: const Icon(Icons.close))
                              ],
                            ),
                          ),
                        );
                      },
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (ctx, i) => const Spacing.mediumHeight(),
                      itemCount: createNewFeeNotifier.selectedDepartments.value.length,
                  ),
                ),

              const Spacing.xLargeHeight(),
              // ................................................
              // Dropdown to select departments
              // ................................................
              DropDownField(
                values: createNewFeeNotifier.listOfDepartments,
                label: "Which Department's students should pay this fee",
                onChanged: createNewFeeNotifier.onDropdownChanged,
                // currentValue: createNewFeeNotifier.selectedRole.value,
              ),

              // ................................................
              // Requirements
              // ................................................
              const Spacing.xLargeHeight(),
              Text(
                'Requirements',
                style: Styles.w400(color: Colors.black54),
              ),
              const Spacing.tinyHeight(),

              // ................................................
              // Add a requirement
              // ................................................
              ShrinkButton(
                onTap: () => Navigator.of(context).pushNamed(Routes.requirements),
                text: (){
                  String text = 'Add a Requirement';

                  if(createNewFeeNotifier.requirements.value.isNotEmpty){
                    text = 'View ${createNewFeeNotifier.requirements.value.length} Requirements';
                  }

                  return text;
                }(),
                isExpanded: false,
                hasBorder: true,
                color: Colors.white,
                textColor: UCPSColors.primary,
              ),

              const Spacing.xxLargeHeight(),
              ShrinkButton(
                onTap: () => createNewFeeNotifier.createNewFee(context),
                text: 'Post fee',
                isExpanded: true,
                isLoading: createNewFeeNotifier.isCreating.value,
              ),

              const Spacing.xxLargeHeight(),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingTextField extends StatelessWidget {
  final ValueNotifier<bool> isLoading;
  final TextEditingController controller;
  final String hintText;
  final bool enabled;
  final Function()? onTap;
  final Function(String)? onChanged;
  // final Function(PayStackCredentialsEntity) data;
  const _LoadingTextField({Key? key, this.onChanged, this.onTap, required this.enabled, required this.hintText, required this.controller, required this.isLoading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return TextFormField(
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          controller: controller,
          onTap: onTap,
          onChanged: onChanged,
          enabled: enabled,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: isLoading.value ? const UCPSLoader(color: UCPSColors.primary,) : null,
          ),
        );
      },
    );
  }
}
