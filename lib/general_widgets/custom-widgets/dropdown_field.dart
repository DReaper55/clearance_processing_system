import 'package:flutter/material.dart';
import 'package:clearance_processing_system/core/helpers/helpers_functions.dart';
import 'package:clearance_processing_system/core/utils/colors.dart';
import 'package:clearance_processing_system/core/utils/text_styles.dart';

class DropDownField<T> extends StatelessWidget {
  const DropDownField({
    Key? key,
    required this.values,
    this.onChanged,
    this.label,
    this.currentValue,
    this.width,
  }) : super(key: key);
  final List<T> values;
  final void Function(T?)? onChanged;
  final String? label;
  final T? currentValue;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: Styles.w400(
              size: 14,
              color: UCPSColors.black,
            ),
          ),
        if (label != null) const SizedBox(height: 8),
        SizedBox(
          height: 55,
          width: width ?? Helpers.width(context),
          child: DropdownButtonFormField<T>(
            style: Styles.w400(
              size: 14,
              color: UCPSColors.prim,
            ),
            icon: const Icon(Icons.keyboard_arrow_down),
            borderRadius: BorderRadius.circular(12),
            decoration: Helpers.dropDecor(),
            value: currentValue ?? values.first,
            autovalidateMode: AutovalidateMode.always,
            items: values
                .map(
                  (e) {
                    String text = e is String ? e : "$e";

                    if(e is Map){
                      text = e.values.first as String;
                    }

                    return DropdownMenuItem<T>(
                      value: e,
                      child: Text(text),
                    );
                  },
                )
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
