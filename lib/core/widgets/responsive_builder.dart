import 'package:flutter/material.dart';

class ResponsiveBuilder extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;

  const ResponsiveBuilder({required this.mobile, this.tablet, super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isTablet = screenWidth > 550 && screenHeight > 750;

    /// Automatically switches between mobile and tablet views.
    return isTablet && tablet != null ? tablet! : mobile;
  }
}
