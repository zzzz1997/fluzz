import 'package:bot_toast/bot_toast.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluzz/controller/locale.dart';
import 'package:fluzz/controller/theme.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
/// 全局参数
///
/// @author zzzz1997
/// @created_time 20191121
///
class Global {
  // 明亮风格
  static bool get styleLight =>
      // ignore: invalid_use_of_visible_for_testing_member, unrelated_type_equality_checks
      SystemChrome.latestStyle?.statusBarBrightness ==
      SystemUiOverlayStyle.dark;

  // SharedPreferences对象
  // static late SharedPreferences sharedPreferences;

  // 日志记录者
  static late Logger logger;

  // 事件
  static final eventBus = EventBus();

  ///
  /// 初始化
  ///
  static init() async {
    Get.lazyPut(() => ThemeController());
    Get.lazyPut(() => LocaleController());
    await Get.putAsync(StorageService().init);
    // sharedPreferences = await SharedPreferences.getInstance();
    logger = Logger();
  }

  ///
  /// 吐司
  ///
  static toast(String message) {
    BotToast.showText(
      text: message,
      textStyle: TextStyle(
        color: Colors.white,
      ),
    );
  }

  ///
  /// 设置状态栏风格
  ///
  static setStyle(bool light) {
    SystemChrome.setSystemUIOverlayStyle(
        light ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark);
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
