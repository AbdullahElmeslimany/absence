import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshUiAttendance {

 
  RefreshController refreshControllerteacher =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    refreshControllerteacher.refreshCompleted();
  }

  void onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    // if (mounted) setState(() {});
    refreshControllerteacher.loadComplete();
  }
}
