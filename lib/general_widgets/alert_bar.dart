import 'package:flutter/material.dart';

import '../core/utils/colors.dart';

class Alert {
  static void showNotification({
    int notificationType = 0,
    String message = "",
    SnackBarAction? action,
    required BuildContext context,
    void Function()? onFinished,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      backgroundColor: notificationType == 1
          ? Colors.red.shade500
          : Colors.green.shade500,
      width: MediaQuery.of(context).size.width * .4,
      // margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(15.0),
      behavior: SnackBarBehavior.floating,
      content: Text(message,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
      duration: const Duration(seconds: 2),
      action: action,
    ));
  }
}
