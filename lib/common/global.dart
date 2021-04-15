import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import 'package:fluzz/controller/locale.dart';
import 'package:fluzz/controller/theme.dart';

///
/// 全局参数
///
/// @author zzzz1997
/// @created_time 20191121
///
class Global {
  // SharedPreferences对象
  static late SharedPreferences sharedPreferences;

  ///
  /// 初始化
  ///
  static init() async {
    await Get.putAsync(StorageService().init);
    sharedPreferences = await SharedPreferences.getInstance();
  }

  ///
  /// 展示吐司
  ///
  static toast(String message) {
    showToast(
      message,
      position: ToastPosition.bottom,
    );
  }
}

///
/// 程序绑定
///
class FluzzBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ThemeController());
    Get.lazyPut(() => LocaleController());
  }
}

///
/// 存储服务
///
class StorageService extends GetxService {
  ///
  /// 初始化
  ///
  Future<SharedPreferences> init() async {
    return await SharedPreferences.getInstance();
  }
}
