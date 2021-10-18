import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
/// 地区控制器
///
/// @author zzzz1997
/// @created_time 20210414
///
class LocaleController extends GetxController {
  // 地区数组
  // static const localeValueList = ['', 'zh-CN', 'en'];
  static const localeValueList = ['zh-CN', 'en'];

  // 地区索引键
  static const kLocalIndex = 'kLocalIndex';

  // 存储对象
  late SharedPreferences sp;

  // 地区位置
  late RxInt localeIndex;

  // 获取地区
  Locale get locale {
    // if (localeIndex.value > 0) {
    final value = localeValueList[localeIndex.value].split('-');
    return Locale(value[0], value.length == 2 ? value[1] : '');
    // }
    // // 跟随系统
    // return null;
  }

  @override
  onInit() {
    super.onInit();

    sp = Get.find<SharedPreferences>();
    localeIndex = (sp.getInt(kLocalIndex) ?? 0).obs;
    Get.locale = locale;
  }

  ///
  /// 切换地区
  ///
  switchLocale(int index) {
    if (localeIndex.value != index) {
      localeIndex(index);
      sp.setInt(kLocalIndex, index);
      Get.updateLocale(locale);
    }
  }

  ///
  /// 地区名称
  ///
  static String localeName(int index) {
    switch (index) {
      // case 0:
      //   return 'autoBySystem'.tr;
      // case 1:
      //   return '中文';
      // case 2:
      //   return 'English';
      case 0:
        return '中文';
      case 1:
        return 'English';
      default:
        return '';
    }
  }
}
