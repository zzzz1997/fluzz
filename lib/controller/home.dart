import 'package:get/get.dart';

///
/// 首页控制器
///
/// @author zhouqin
/// @created_time 20210810
///
class HomeController extends GetxController {
  // 位置
  var index = 0.obs;

  ///
  /// 点击事件
  ///
  onTap(i) {
    if (index.value != i) {
      index(i);
    }
  }
}
