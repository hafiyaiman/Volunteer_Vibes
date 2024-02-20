import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget largeScreen;
  final Widget? mediumScreen;
  final Widget? smallScreen;

  const ResponsiveWidget({
    super.key,
    required this.largeScreen,
    this.mediumScreen,
    this.smallScreen,
  });

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 750;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 750 &&
        MediaQuery.of(context).size.width <= 1250;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 1250;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 1200) {
        return largeScreen;
      } else if (constraints.maxWidth >= 750 && constraints.maxWidth <= 1250) {
        return mediumScreen ?? largeScreen;
      } else {
        return smallScreen ?? largeScreen;
      }
    });
  }
}
