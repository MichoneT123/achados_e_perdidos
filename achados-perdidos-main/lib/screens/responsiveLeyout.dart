import 'package:flutter/material.dart';

class ResponsiveLayoutLoginScreen extends StatelessWidget {
  const ResponsiveLayoutLoginScreen({
    Key? key,
    required this.mobileScaffold,
    required this.desktopScaffold,
  }) : super(key: key);

  final Widget mobileScaffold;

  final Widget desktopScaffold;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 500) {
          return mobileScaffold;
        } else {
          return desktopScaffold;
        }
      },
    );
  }
}
