import 'package:flutter/cupertino.dart';

import '../core/utils/colors.dart';

class NetServeLoader extends StatelessWidget {
  const NetServeLoader({
    Key? key,
    this.color,
    this.size = 35,
  }) : super(key: key);
  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(
        color: color ?? UCPSColors.white,
        animating: true,
      ),
    );
  }
}
