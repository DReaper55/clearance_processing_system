import 'package:clearance_processing_system/core/helpers/helpers_functions.dart';
import 'package:clearance_processing_system/core/utils/dimensions.dart';
import 'package:clearance_processing_system/core/utils/strings.dart';
import 'package:clearance_processing_system/general_widgets/UCPSScaffold.dart';
import 'package:clearance_processing_system/general_widgets/custom-widgets/custom_network_image.dart';
import 'package:clearance_processing_system/general_widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../notifiers/student_req_notifier.dart';

class StudentRequirementsPage extends HookConsumerWidget {
  const StudentRequirementsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentReqNotifier = ref.watch(studentReqNotifierProvider);

    useEffect(() {
      Future.delayed(const Duration(milliseconds: 500), () {
        studentReqNotifier.setData();
      });

      return () {};
    }, []);

    return UCPSScaffold(
      title: AppStrings.clearance,
      showLeadingBtn: true,
      child: SizedBox(
        width: Helpers.width(context),
        height: Helpers.height(context),
        child: ListView.separated(
          itemBuilder: (ctx, i) {
            final requirements = studentReqNotifier.feeCat.value.requirementEntities![i];
            final uploadedReq = requirements.uploadedReqEntity;

            return Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.large,
                    vertical: Dimensions.medium),
                child: ListTile(
                  title: Text(requirements.title!),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacing.mediumHeight(),

                      Text(requirements.description ?? ''),

                      if(uploadedReq != null && uploadedReq.id != null)
                      const Spacing.smallHeight(),

                      if(uploadedReq != null && uploadedReq.id != null)
                        Text('Status: ${uploadedReq.verificationStatus}')
                    ],
                  ),
                  trailing: SizedBox(
                    width: Helpers.width(context) * .3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if(uploadedReq != null && uploadedReq.imageUrl != null && uploadedReq.imageFile == null)
                          Container(
                            height: 100.0,
                            width: 50.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.small),
                            ),
                            child: CustomNetworkImage(
                              src: uploadedReq.imageUrl!,
                              boxFit: BoxFit.cover,
                            ),
                          ),

                        if(studentReqNotifier
                            .feeCat
                            .value
                            .requirementEntities![i]
                            .uploadedReqEntity != null
                            && studentReqNotifier
                                .feeCat
                                .value
                                .requirementEntities![i]
                                .uploadedReqEntity!
                                .imageFile != null)
                          Container(
                            height: 100.0,
                            width: 50.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.small),
                                image: DecorationImage(fit: BoxFit.cover, image: MemoryImage(studentReqNotifier.feeCat.value.requirementEntities![i].uploadedReqEntity!.imageFile!))
                            ),
                          ),

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
                            onPressed: () => studentReqNotifier.pickFile(requirements.requirementID!),
                            child: const Text("Upload new document")),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (ctx, i) => const Spacing.mediumHeight(),
          itemCount: studentReqNotifier.feeCat.value.requirementEntities != null ? studentReqNotifier.feeCat.value.requirementEntities!.length : 0,
        ),
      ),
    );
  }
}