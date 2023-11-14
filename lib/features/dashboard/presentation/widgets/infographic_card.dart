import 'package:clearance_processing_system/core/utils/colors.dart';
import 'package:clearance_processing_system/core/utils/dimensions.dart';
import 'package:clearance_processing_system/core/utils/text_styles.dart';
import 'package:clearance_processing_system/general_widgets/spacing.dart';
import 'package:flutter/material.dart';

class InfographicCard extends StatelessWidget {
  final Color? bgColor;
  final Color? titleTextColor;
  final Color? bodyTextColor;
  final String titleText;
  final String bodyText;
  const InfographicCard({super.key, this.bgColor, this.bodyTextColor, this.titleTextColor, required this.bodyText, required this.titleText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.medium, horizontal: Dimensions.large),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.medium),
        color: bgColor ?? UCPSColors.primary,
      ),
      child: Center(
        child: Column(
          children: [
            Text(titleText, style: Styles.w400(color: titleTextColor ?? Colors.white60, size: 14),),
            const Spacing.mediumHeight(),

            Text(bodyText, style: Styles.w500(color: bodyTextColor ?? Colors.white, size: 22))
          ],
        ),
      ),
    );
  }
}
