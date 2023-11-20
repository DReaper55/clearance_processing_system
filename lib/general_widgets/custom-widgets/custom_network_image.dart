import 'package:flutter/material.dart';

import '../../core/utils/strings.dart';

class CustomNetworkImage extends StatelessWidget {
  final String src;
  final double? height;
  final double? width;
  final BoxFit boxFit;
  const CustomNetworkImage({Key? key, required this.src, this.boxFit = BoxFit.cover, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
        src,
        fit: BoxFit.cover,
        height: height,
        width: width,
        errorBuilder: (context, object, stackTrace) {
          return const SizedBox();
          // return Image.asset(
          //   AssetStrings.logo,
          //   fit: BoxFit.cover,
          //   height: height,
          //   width: width,
          // );
        }, loadingBuilder: (context, child, loadingProgress) {
      if (loadingProgress != null) {
        if (loadingProgress.cumulativeBytesLoaded ==
            loadingProgress.expectedTotalBytes) {
          return child;
        }
        return const Center(
          child: Icon(Icons.person),
        );
      } else {
        return child;
      }
    });
  }
}
