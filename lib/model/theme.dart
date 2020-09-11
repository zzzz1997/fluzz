import 'package:dart_mock/dart_mock.dart' as mock;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common/global.dart';

///
/// 主题模型
///
/// @author zzzz1997
/// @created_time 20191122
///
class ThemeModel extends ChangeNotifier {
  // 夜间模式键
  static const kIsDarkMode = 'kIsDarkMode';

  // 主题颜色键
  static const kThemeColor = 'kThemeColor';

  // 字体索引键
  static const kFontIndex = 'kFontIndex';

  // 字体数组
  static const fontValueList = ['system', 'kuaile'];

  // 夜间模式
  bool _isDarkMode;

  // 获取夜间模式
  bool get isDarkMode => _isDarkMode;

  // 主题色
  MaterialColor _themeColor;

  // 字体索引
  int _fontIndex;

  // 获取字体索引
  int get fontIndex => _fontIndex;

  ThemeModel() {
    _isDarkMode = Global.sharedPreferences.getBool(kIsDarkMode) ?? false;
    _themeColor =
        Colors.primaries[Global.sharedPreferences.getInt(kThemeColor) ?? 5];
    _fontIndex = Global.sharedPreferences.getInt(kFontIndex) ?? 0;
  }

  ///
  /// 切换主题
  ///
  switchTheme({bool isDarkMode, MaterialColor color}) {
    _isDarkMode = isDarkMode ?? _isDarkMode;
    _themeColor = color ?? _themeColor;
    notifyListeners();
    int index = Colors.primaries.indexOf(_themeColor);
    Global.sharedPreferences.setBool(kIsDarkMode, _isDarkMode);
    Global.sharedPreferences.setInt(kThemeColor, index);
  }

  ///
  /// 切换随机主题
  ///
  switchRandomTheme() {
    switchTheme(
      isDarkMode: mock.boolean(),
      color: Colors.primaries[mock.integer(max: Colors.primaries.length - 1)],
    );
  }

  ///
  /// 切换字体
  ///
  switchFont(int index) {
    _fontIndex = index;
    switchTheme();
    Global.sharedPreferences.setInt(kFontIndex, index);
  }

  ///
  /// 主题
  ///
  ThemeData themeData({bool platformDarkMode = false}) {
    bool isDark = platformDarkMode || _isDarkMode;
    Brightness brightness = isDark ? Brightness.dark : Brightness.light;

    MaterialColor themeColor = _themeColor;
    Color accentColor = isDark ? themeColor[700] : _themeColor;
    ThemeData themeData = ThemeData(
        brightness: brightness,
        primaryColorBrightness: Brightness.dark,
        accentColorBrightness: Brightness.dark,
        primarySwatch: themeColor,
        accentColor: accentColor,
        fontFamily: fontValueList[fontIndex]);

    Color primaryColor = themeData.primaryColor;
    Color dividerColor = themeData.dividerColor;
    Color errorColor = themeData.errorColor;
    Color disabledColor = themeData.disabledColor;

    double width = 0.5;

    themeData = themeData.copyWith(
      brightness: brightness,
      accentColor: accentColor,
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: themeColor,
        brightness: brightness,
      ),
      appBarTheme: themeData.appBarTheme.copyWith(elevation: 0),
      splashColor: themeColor.withAlpha(50),
      hintColor: themeData.hintColor.withAlpha(90),
      errorColor: Colors.red,
      cursorColor: accentColor,
      textTheme: themeData.textTheme.copyWith(
        subtitle2: themeData.textTheme.subtitle2.copyWith(
          textBaseline: TextBaseline.alphabetic,
        ),
      ),
      textSelectionColor: accentColor.withAlpha(60),
      textSelectionHandleColor: accentColor.withAlpha(60),
      toggleableActiveColor: accentColor,
      chipTheme: themeData.chipTheme.copyWith(
        pressElevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 10),
        labelStyle: themeData.textTheme.caption,
        backgroundColor: themeData.chipTheme.backgroundColor.withOpacity(0.1),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(fontSize: 14),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: width,
            color: errorColor,
          ),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 0.7,
            color: errorColor,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: width,
            color: primaryColor,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: width,
            color: dividerColor,
          ),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            width: width,
            color: dividerColor,
          ),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: width,
            color: disabledColor,
          ),
        ),
      ),
    );
    return themeData;
  }

  ///
  /// 获取字体名称
  ///
  static String fontName(index) {
    switch (index) {
      case 0:
        return Global.s.autoBySystem;
      case 1:
        return Global.s.fontKuaiLe;
      default:
        return '';
    }
  }
}
