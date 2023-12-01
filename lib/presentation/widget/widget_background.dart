import 'package:flutter/material.dart';
import '../res/images_data.dart';

/// Background color for app, it desgin in gradient color
class WidgetBackground extends StatelessWidget {
  final Widget child;
  const WidgetBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            ImagesData.background,
            fit: BoxFit.cover,
          ),
        ),
        child,
      ],
    );
  }
}
