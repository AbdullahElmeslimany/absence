import 'dart:async';
import 'package:flutter/material.dart';

class RefreshWidget {
  // static final GlobalKey<LiquidPullToRefreshState> refreshIndicatorKey =
  //     GlobalKey<LiquidPullToRefreshState>();
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();

  static Future<void> handleRefresh() {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 2), () {
      completer.complete();
    });
    return completer.future.then<void>((_) {
      ScaffoldMessenger.of(scaffoldKey.currentState!.context).showSnackBar(
        SnackBar(
          content: const Text('Refresh complete'),
          action: SnackBarAction(
            label: 'RETRY',
            onPressed: () {
              // refreshIndicatorKey.currentState!.show();
            },
          ),
        ),
      );
    });
  }
}
