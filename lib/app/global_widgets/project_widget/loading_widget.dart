import 'package:flutter/material.dart';

import '../shared/ui_helpers.dart';

class LoadingWidget extends StatelessWidget {
  final bool inScaffold;

  const LoadingWidget({Key? key, this.inScaffold = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return inScaffold
        ? Scaffold(
            body: Center(
              child: UiHelper.spinKitProgressIndicator(),
            ),
          )
        : Center(
            child: UiHelper.spinKitProgressIndicator(),
          );
  }
}
