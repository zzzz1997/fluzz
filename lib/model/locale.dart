import 'package:flutter/material.dart';

import '../common/global.dart';

///
/// 地区模型
///
/// @author zzzz1997
/// @created_time 20191122
///
class LocaleModel extends ChangeNotifier {
  // 地区数组
  static const localeValueList = ['', 'zh-CN', 'en'];

  // 地区索引键
  static const kLocalIndex = 'kLocalIndex';

  // 地区索引
  int _localeIndex;

  // 获取地区索引
  int get localeIndex => _localeIndex;

  // 获取地区
  Locale get locale {
    if (_localeIndex > 0) {
      var value = localeValueList[_localeIndex].split('-');
      return Locale(value[0], value.length == 2 ? value[1] : '');
    }
    // 跟随系统
    return null;
  }

  LocaleModel() {
    _localeIndex = Global.sharedPreferences.getInt(kLocalIndex) ?? 0;
  }

  ///
  /// 切换地区
  ///
  switchLocale(int index) {
    _localeIndex = index;
    notifyListeners();
    Global.sharedPreferences.setInt(kLocalIndex, index);
  }

  ///
  /// 地区名称
  ///
  static String localeName(index) {
    switch (index) {
      case 0:
        return Global.s.autoBySystem;
      case 1:
        return '中文';
      case 2:
        return 'English';
      default:
        return '';
    }
  }
}
