import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/main.dart';

class FlushBar {
  /// Dialog arlet
  void showFlushBar({
    String? key,
    BuildContext? context,
    Color backgroundColor = Colors.white,
    String? image,

    /// content of alert
    String? title,

    /// How long until Flushbar will hide itself
    int seconds = 3,
    Function(Flushbar<dynamic>)? onTap,
  }) {
    Flushbar(
      key: Key(key ?? ""),
      messageText: Text(title ?? ""),
      padding: const EdgeInsets.all(25),
      margin: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(8.0),
      backgroundColor: backgroundColor,
      flushbarPosition: FlushbarPosition.TOP,
      shouldIconPulse: image != null ? false : true,
      onTap: onTap,
      duration: Duration(seconds: seconds),
    )
        .show(
          context ?? StateManager.navigatorKey.currentContext!,
        )
        .timeout(
          Duration(seconds: seconds),
          onTimeout: () {},
        );
  }
}
