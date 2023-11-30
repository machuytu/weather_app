import 'package:flutter/material.dart';

import '../widget/loading_widget.dart';

class DialogService {
  showLoaderDialogShort(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    AlertDialog alert = AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: Colors.transparent,
      content: SizedBox(
          height: height,
          width: width,
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
