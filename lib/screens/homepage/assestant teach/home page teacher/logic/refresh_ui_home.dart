import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshUi {
  RefreshController refreshControllerteacherhome =
      RefreshController(initialRefresh: true);

  void onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    refreshControllerteacherhome.refreshCompleted();
  }

  void onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    refreshControllerteacherhome.loadComplete();
  }
}
