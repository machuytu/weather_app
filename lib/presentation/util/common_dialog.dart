import 'package:flutter/material.dart';
import '../widget/loading_widget.dart';

class DialogService {
  showLoaderDialogShort(BuildContext context) {
    var size = MediaQuery.of(context).size;

    AlertDialog alert = AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: Colors.transparent,
      content: SizedBox(
          height: size.height,
          width: size.width,
          child: const Center(child: LoadingWidget())),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return alert;
      },
    );
  }
}
