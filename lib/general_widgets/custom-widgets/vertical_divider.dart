import 'package:flutter/material.dart';

class CustomVerticalDivider extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  const CustomVerticalDivider({Key? key, this.width, this.color, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 1,
      height: height ?? 50.0,
      color: color ?? Colors.grey.shade200,
    );
  }
}
