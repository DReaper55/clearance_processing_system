import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../../general_widgets/alert_bar.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';

class Helpers {
  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;
  static InputDecoration inputdecor({
    String? hintText,
    TextStyle? hintStyle,
    EdgeInsetsGeometry? contentPadding,
  }) =>
      InputDecoration(
        contentPadding: contentPadding,
        filled: true,
        hintText: hintText,
        hintStyle: hintStyle,
        fillColor: UCPSColors.white,
        border: InputBorder.none,
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.small),
          borderSide: BorderSide.none,
        ),
        labelStyle: const TextStyle(color: UCPSColors.black),
        /*enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: NetServeColors.primary,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: NetServeColors.primary,
            width: 2.0,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: NetServeColors.primary,
            width: 2.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: NetServeColors.red,
            width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: NetServeColors.red,
            width: 2.0,
          ),
        ),*/
      );
  static InputDecoration dropDecor({
    String? hintText,
    EdgeInsetsGeometry? contentPadding,
  }) =>
      InputDecoration(
        contentPadding: contentPadding,
        filled: true,
        hintText: hintText,
        fillColor: UCPSColors.white,
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        labelStyle: const TextStyle(color: UCPSColors.black),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      );
  static OutlineInputBorder replybod(double radius) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(
          color: UCPSColors.primary,
          width: 2.0,
        ),
      );
}

void showError({
  required String text,
  required BuildContext context,
  void Function()? onFinished,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  Alert.showNotification(
    message: text,
    context: context,
    notificationType: 1,
    onFinished: onFinished,
  );
}

void showSuccess({
  required String text,
  required BuildContext context,
  void Function()? onFinished,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  Alert.showNotification(
    message: text,
    context: context,
    notificationType: 0,
    onFinished: onFinished,
  );
}

String showDate({
  required DateTime dateSent,
  required BuildContext context,
}) {
  final currentDay = DateTime.now();
  if (dateSent.day == currentDay.day &&
      dateSent.month == currentDay.month &&
      dateSent.year == currentDay.year) {
    return 'Today';
  }
  if (dateSent.day - currentDay.day == -1) {
    return 'Yesterday';
  }
  if (dateSent.difference(currentDay).inDays >= -2) {
    return DateFormat('EEEEE, ', 'en').format(dateSent) +
        TimeOfDay.fromDateTime(DateTime.now()).format(context);
  } else {
    log(dateSent.toString());
    log(currentDay.toString());
    return DateFormat("d'th', MMMM yyyy | ", 'en').format(dateSent) +
        TimeOfDay.fromDateTime(DateTime.now()).format(context);
  }
}
