// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:clearance_processing_system/core/utils/dimensions.dart';

class Spacing extends StatelessWidget {
  final double height;
  final double width;

  const Spacing.height(this.height) : width = Dimensions.zero;

  const Spacing.tinyHeight() : this.height(Dimensions.tiny);
  const Spacing.smallHeight() : this.height(Dimensions.small);
  const Spacing.mediumHeight() : this.height(Dimensions.medium);
  const Spacing.bigHeight() : this.height(Dimensions.big);
  const Spacing.bigLargeHeight() : this.height(Dimensions.bigLarge);
  const Spacing.largeHeight() : this.height(Dimensions.large);
  const Spacing.xLargeHeight() : this.height(Dimensions.xLarge);
  const Spacing.xxLargeHeight() : this.height(Dimensions.xxLarge);

  const Spacing.width(this.width) : height = Dimensions.zero;

  const Spacing.tinyWidth() : this.width(Dimensions.tiny);
  const Spacing.smallWidth() : this.width(Dimensions.small);
  const Spacing.mediumWidth() : this.width(Dimensions.medium);
  const Spacing.bigWidth() : this.width(Dimensions.big);
  const Spacing.bigLargeWidth() : this.height(Dimensions.bigLarge);
  const Spacing.largeWidth() : this.width(Dimensions.large);
  const Spacing.xLargeWidth() : this.height(Dimensions.xLarge);
  const Spacing.xxLargeWidth() : this.height(Dimensions.xxLarge);

  const Spacing.empty()
      : width = Dimensions.zero,
        height = Dimensions.zero;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height, width: width);
  }
}
