import 'package:clearance_processing_system/core/helpers/extensions.dart';
import 'package:clearance_processing_system/core/helpers/helpers_functions.dart';
import 'package:clearance_processing_system/core/utils/dimensions.dart';
import 'package:clearance_processing_system/core/utils/strings.dart';
import 'package:clearance_processing_system/general_widgets/UCPSScaffold.dart';
import 'package:clearance_processing_system/general_widgets/custom-widgets/vertical_divider.dart';
import 'package:clearance_processing_system/general_widgets/shrink_button.dart';
import 'package:clearance_processing_system/general_widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../notifiers/student_info_notifier.dart';

class StudentInfoPage extends HookConsumerWidget {
  const StudentInfoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentInfoNotifier = ref.watch(studentInfoNotifierProvider);

    useEffect(() {

      Future.delayed(const Duration(milliseconds: 500), () {
        studentInfoNotifier.setData();
      });

      return () {
      };
    }, []);

    return UCPSScaffold(
      title: (){
        String text = 'Student record';

        if(studentInfoNotifier.studentCategory.value != null){
          String mText = studentInfoNotifier.studentCategory.value!.studentEntity!.fullName!;
          text = "$mText's record";
        }

        return text;
      }(),
      child: SizedBox(
        width: Helpers.width(context),
        child: Row(
          children: [
            Expanded(child: _StudentInfo(studentInfoNotifier)),

            if(studentInfoNotifier.showPaymentInfo.value || studentInfoNotifier.showUploadInfo.value)
            const Spacing.largeWidth(),

            if(studentInfoNotifier.showPaymentInfo.value)
            Expanded(child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.medium),
                  border: Border.all(color: Colors.black45)
                ),
                height: Helpers.height(context),
                margin: const EdgeInsets.only(bottom: Dimensions.large),
                child: _PaymentInfo(studentInfoNotifier))),

            if(studentInfoNotifier.showUploadInfo.value)
            Expanded(child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.medium),
                  border: Border.all(color: Colors.black45)
                ),
                height: Helpers.height(context),
                margin: const EdgeInsets.only(bottom: Dimensions.large),
                child: _UploadInfo(studentInfoNotifier))),
          ],
        ),
      ),
    );
  }
}

class _StudentInfo extends HookWidget {
  final StudentInfoNotifier studentInfoNotifier;
  const _StudentInfo(this.studentInfoNotifier);

  @override
  Widget build(BuildContext context) {
    final emailCtrl = useTextEditingController();
    final fullNameCtrl = useTextEditingController();
    final matricCtrl = useTextEditingController();
    final facultyCtrl = useTextEditingController();
    final deptCtrl = useTextEditingController();

    useEffect(() {
      Future.delayed(const Duration(milliseconds: 700), () {
        final studentEntity = studentInfoNotifier.studentCategory.value!.studentEntity;

        if(studentEntity == null) return;

        emailCtrl.text = studentEntity.email ?? '';
        fullNameCtrl.text = studentEntity.fullName ?? '';
        matricCtrl.text = studentEntity.matric ?? '';
        facultyCtrl.text = studentEntity.faculty ?? '';
        deptCtrl.text = studentEntity.department ?? '';
      });

      return () {};
    });

    return Column(
      children: [
        const Spacing.xxLargeHeight(),

        // ............................
        // Buttons to view transaction
        // and uploads
        // ............................
        SizedBox(
          height: 60.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              ShrinkButton(
                onTap: studentInfoNotifier.displayPayment,
                text: 'View payments',
              ),
              const Spacing.largeWidth(),

              ShrinkButton(
                onTap: studentInfoNotifier.displayUpload,
                text: 'View uploaded documents',
              ),
            ],
          ),
        ),
        const Divider(),
        const Spacing.xLargeHeight(),

        SingleChildScrollView(
          child: SizedBox(
            width: Helpers.width(context),
            child: Column(
              children: [
                TextFormField(
                  controller: emailCtrl,
                  decoration: const InputDecoration(labelText: 'Email'),
                  // validator: Validators.email(),
                ),

                const Spacing.mediumHeight(),
                TextFormField(
                  controller: fullNameCtrl,
                  decoration: const InputDecoration(labelText: 'Full name'),
                  // validator: Validators.notEmpty(),
                ),

                const Spacing.mediumHeight(),
                TextFormField(
                  controller: matricCtrl,
                  decoration: const InputDecoration(labelText: 'Matric number'),
                  // validator: Validators.notEmpty(),
                ),

                const Spacing.mediumHeight(),
                TextFormField(
                  controller: facultyCtrl,
                  decoration: const InputDecoration(labelText: 'Faculty'),
                  // validator: Validators.notEmpty(),
                ),

                const Spacing.mediumHeight(),
                TextFormField(
                  controller: deptCtrl,
                  decoration: const InputDecoration(labelText: 'Department'),
                  // validator: Validators.notEmpty(),
                ),

                const Spacing.xxLargeHeight(),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _PaymentInfo extends StatelessWidget {
  final StudentInfoNotifier studentInfoNotifier;

  const _PaymentInfo(this.studentInfoNotifier);

  @override
  Widget build(BuildContext context) {
    final userRecords = studentInfoNotifier.studentCategory.value!.paymentEntity!;
    List<DataRow> dataRows = userRecords.map((e) => DataRow(cells: [
      DataCell(Text(e.referenceCode!)),
      DataCell(Text((){
        if(e.amount != null){
          return 'N${e.amount!.addComma()}';
        }

        return '';
      }())),
      DataCell(Text(e.description!)),
      // DataCell(Text(e.feeEntity!.title ?? '')),
      DataCell(Text(e.dateTime!)),
    ])).toList();


    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        rows: dataRows,
        columns: const [
          DataColumn(label: Text("Reference code")),
          DataColumn(label: Text("Amount")),
          DataColumn(label: Text("Description")),
          // DataColumn(label: Text("Clearance")),
          DataColumn(label: Text("Date paid")),
        ],
      ),
    );
  }
}

class _UploadInfo extends StatelessWidget {
  final StudentInfoNotifier studentInfoNotifier;

  const _UploadInfo(this.studentInfoNotifier);

  @override
  Widget build(BuildContext context) {
    final userRecords = studentInfoNotifier.studentCategory.value!.requirementEntity!;
    List<DataRow> dataRows = userRecords.map((e) => DataRow(cells: [
      DataCell(Text(e.requirementID!)),
      DataCell(Text(e.title!)),
      DataCell(Text((){
        String text = 'No';

        if(e.uploadedReqEntity!.isStudentPaid != null
            && e.uploadedReqEntity!.isStudentPaid!){
          text = 'Yes';
        }

        return text;
      }())),
      DataCell(Text(e.uploadedReqEntity!.verificationStatus ?? '')),
      DataCell(ShrinkButton(
        onTap: (){},
        padding: EdgeInsets.zero,
        width: 130,
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
        text: 'View document',
      )),
      DataCell(ShrinkButton(
        onTap: () => studentInfoNotifier.updateStatus(context, document: e.uploadedReqEntity!, status: false),
        padding: EdgeInsets.zero,
        width: 130,
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
        text: 'Reject document',
      )),
      DataCell(ShrinkButton(
        onTap: () => studentInfoNotifier.updateStatus(context, document: e.uploadedReqEntity!, status: true),
        padding: EdgeInsets.zero,
        width: 130,
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
        text: 'Approve document',
      )),
    ])).toList();


    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        rows: dataRows,
        columns: const [
          DataColumn(label: Text("Requirement ID")),
          DataColumn(label: Text("Requirement")),
          DataColumn(label: Text("Has student paid")),
          DataColumn(label: Text("Verification status")),
          DataColumn(label: Text("Actions")),
          DataColumn(label: Text("Actions")),
          DataColumn(label: Text("Actions")),
        ],
      ),
    );
  }
}

