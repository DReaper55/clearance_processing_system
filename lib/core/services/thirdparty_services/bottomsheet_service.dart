import 'package:flutter/material.dart';

class BottomSheetService {
  static Future showCustomBottomSheet(BuildContext context, {required Widget content, double? minHeight, double? maxHeight}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * (minHeight ?? maxHeight ?? 0.9),
            maxHeight: MediaQuery.of(context).size.height * (maxHeight ?? minHeight ?? 0.9),
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: content,
        );
      },
    );
  }
}
