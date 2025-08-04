import 'package:flutter/material.dart';

abstract class AppColors {

  static const Color appPrimaryColor = Color(0xFF114654);
  static const Color buttonColor = Color(0xFF07548A);
  static const Color pageBackground = Color(0xFFF5F5F5);
  static const Color statusBarColor = Color(0xFF07548A);

  static const Color appBarColor = Color(0xFF114654);

  static const Color appBarIconColor = Color(0xFFFFFFFF);
  static const Color appBarTextColor = Color(0xFFFFFFFF);

  static const Color centerTextColor = Colors.grey;
  static const MaterialColor colorPrimarySwatch = Colors.cyan;
  static const Color colorPrimary = Color(0xFF38686A);
  static const Color colorAccent = Color(0xFF38686A);
  static const Color colorLightGreen = Color(0xFF00EFA7);
  static const Color colorGreen = Color(0xFF269000);

  static const Color borderColor = Color(0xffE2E2E2);
  static const Color colorWhite = Color(0xFFFFFFFF);
  static const Color lightGreyColor = Color(0xFFC4C4C4);
  static const Color errorColor = Color(0xFFAB0B0B);


  static const Color iconColorDefault = Colors.grey;

  static Color timelineDividerColor = const Color(0x5438686A);
  // static Color borderColor = const Color(0xffebebeb);
  static Color dividerColor = const Color(0xffcacaca);




  static const Color gradientStartColor = Colors.black87;
  static const Color gradientEndColor = Colors.transparent;
  static const Color silverAppBarOverlayColor = Color(0x80323232);

  static const Color switchActiveColor = colorPrimary;
  static const Color switchInactiveColor = Color(0xFFABABAB);
  static Color elevatedContainerColorOpacity = Colors.grey.withOpacity(0.5);
  static const Color suffixImageColor = Colors.grey;

  static const LinearGradient appBackgroundColor = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xffe6f9ff),
      Color(0xffe9ffe8),
      Color(0xfffff6e2),
    ],
  );

  static const LinearGradient appButtonColor = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xCC0D70DD),
      Color(0xCC1B85EF),
      Color(0xFF0064E1),
    ],
  );
}
