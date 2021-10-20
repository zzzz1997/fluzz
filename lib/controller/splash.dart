import 'dart:async';

import 'package:fluzz/common/route.dart';
import 'package:get/get.dart';

///
/// 开屏控制器
///
/// @author zzzz1997
/// @created_time 20191121
///
class SplashController extends GetxController {
  // 定时器
  Timer? timer;
  
  @override
  void onReady() {
    super.onReady();

    timer = Timer(const Duration(seconds: 2), () {
      Get.offAllNamed(FluzzRoute.home);
    });
  }
  
  @override
  void onClose() {
    timer?.cancel();
    timer = null;
    super.onClose();
  }
}