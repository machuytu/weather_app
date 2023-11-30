import 'package:flutter/material.dart';

import '../res/images_data.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 25.0,
        width: 25.0,
        child: Image.asset(
          ImagesData.loading,
        ),
      ),
    );
  }
}
