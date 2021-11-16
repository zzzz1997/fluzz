import 'package:get/get.dart';

///
/// 国际化
///
/// @author zzzz1997
/// @created_time 20210414
///
class FluzzTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'zh_CN': {
          '_locale': 'zh_CN',
          'appName': 'FLUZZ',
          'darkMode': '夜间模式',
          'colorTheme': '色彩主题',
          'font': '字体',
          'autoBySystem': '跟随系统',
          'fontKuaiLe': '快乐字体',
          'language': '语言',
          'home': '首页',
          'setting': '设置',
          'load': '加载',
          'refresh': '刷新',
          'increase': '增加',
          'noMore': '没有更多了'
        },
        'en': {
          '_locale': 'en',
          'appName': 'FLUZZ',
          'darkMode': 'Dark Mode',
          'colorTheme': 'Color Theme',
          'font': 'Font',
          'autoBySystem': 'Auto',
          'fontKuaiLe': 'ZCOOL KuaiLe',
          'language': 'Language',
          'home': 'Home',
          'setting': 'Setting',
          'load': 'Load',
          'refresh': 'Refresh',
          'increase': 'Increase',
          'noMore': 'No More'
        }
      };
}
