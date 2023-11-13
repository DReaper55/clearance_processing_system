import 'package:flutter/material.dart';

class UCPSColors {
  UCPSColors._();
  static const Color primary = Color(0xFF004694);
  static const Color prim = Color(0xFF004694);

  static const Color secondary = Color(0xFFAD132A);

  static const Color primaryLight = Color(0xFF2245B8);
  static const Color primLight = Color(0x14004694);
  static const Color primaryFade = Color(0xFF69759F);
  static const Color deepgrey = Color(0xFF59565F);
  static const Color grey = Color(0xFF79777E);
  static const Color green = Color(0xFF0B7957);
  static const Color lightGreen = Color(0xFFF6FEFC);
  static const Color brightGreen = Color.fromRGBO(29, 197, 36, 1);
  static const Color warning = Color(0xFFE58B0B);
  static const Color purple = Color(0xFFA9BDFF);
  static const Color lightGrey = Color(0xFFA6A6A6);
  static const Color white = Color(0xFFFFFFFF);
  static const Color milkWhite = Color(0xFFF5F5F5);
  // static const Color senderBubble = Color(0XFFF8F7FC);
  static const Color senderBubble = Color.fromRGBO(0, 70, 148, .07);
  static const Color receiverBubble = Color(0XFFF6FEFC);
  static const Color red = Color(0xFFD8372C);
  static const Color redLight = Color(0xFFFCE9E9);
  static const Color black = Color(0xFF353535);
  static const Color greyFill = Color(0xFFf8f8f8);
  static const Color bubbleGrey = Color(0xFFf1f0f5);
  static const MaterialColor primarysWatch = MaterialColor(
    _bluePrimaryValue,
    <int, Color>{
      50: Color(0xFFE3F2FD),
      100: Color(0xFFBBDEFB),
      200: Color(0xFF90CAF9),
      300: Color(0xFF64B5F6),
      400: Color(0xFF0D47A1),
      500: Color(_bluePrimaryValue),
      600: Color(_bluePrimaryValue),
      700: Color(0xFF1976D2),
      800: Color(0xFF1565C0),
      900: Color(0xFF0D47A4),
    },
  );
  static const int _bluePrimaryValue = 0xFF004694;
}

class NetServeShadows {
  NetServeShadows._();

  static const BoxShadow cardShadow = BoxShadow(
    color: UCPSColors.lightGrey,
    offset: Offset(3.0, 3.0), //(x,y)
    blurRadius: 3.0,
  );
  static const BoxShadow shapeDecorCardShadow = BoxShadow(
    color: Color(0x1E000000),
    blurRadius: 13,
    offset: Offset(0, 3),
    spreadRadius: 0,
  );
  static const BoxShadow defaultShadow = BoxShadow(
    color: UCPSColors.lightGrey,
    offset: Offset(0.0, 1.0), //(x,y)
    blurRadius: 7.0,
  );
  static const BoxShadow focusShadow = BoxShadow(
    color: UCPSColors.primaryFade,
    offset: Offset(0.0, 1.0), //(x,y)
    blurRadius: 7.0,
  );
  static const BoxShadow errorShadow = BoxShadow(
    color: UCPSColors.red,
    offset: Offset(0.0, 1.0), //(x,y)
    blurRadius: 7.0,
  );
}

class NetServeWidgetGradient {
  NetServeWidgetGradient._();

  static const LinearGradient gradient = LinearGradient(
    colors: [
      Color(0xFF004694),
      Color(0xFFAD132A)
    ], // Replace with your desired gradient colors
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
