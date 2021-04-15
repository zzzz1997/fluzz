import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluzz/controller/locale.dart';
import 'package:fluzz/controller/theme.dart';

import 'package:get/get.dart';

import 'package:fluzz/common/global.dart';
import 'package:fluzz/common/resource.dart';

///
/// 主页面
///
/// @author zzzz1997
/// @created_time 20200911
///
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final localeController = Get.find<LocaleController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('appName'.tr),
      ),
      body: SingleChildScrollView(
        child: ListTileTheme(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Global.toast('FLUZZ');
                },
                child: Icon(
                  IconFonts.fluzz,
                  size: 200,
                  color: Theme.of(context).accentColor,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Material(
                color: Theme.of(context).cardColor,
                child: ListTile(
                  title: Text('darkMode'.tr),
                  onTap: () {
                    // _switchDarkMode(context);
                    themeController.switchTheme(mode: !Get.isDarkMode);
                  },
                  leading: Transform.rotate(
                    angle: -pi,
                    child: Icon(
                      Theme.of(context).brightness == Brightness.light
                          ? Icons.brightness_5
                          : Icons.brightness_2,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  trailing: Switch(
                    activeColor: Theme.of(context).accentColor,
                    value: Theme.of(context).brightness == Brightness.dark,
                    onChanged: (_) {
//                      switchDarkMode();
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Material(
                color: Theme.of(context).cardColor,
                child: ExpansionTile(
                  title: Text('colorTheme'.tr),
                  leading: Icon(
                    Icons.color_lens,
                    color: Theme.of(context).accentColor,
                  ),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        children: <Widget>[
                          ...Colors.primaries
                              .map((color) => Material(
                                    color: color,
                                    child: InkWell(
                                      onTap: () {
                                        themeController.switchTheme(
                                            color: color);
                                      },
                                      child: SizedBox(
                                        width: 40,
                                        height: 40,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          Material(
                            child: InkWell(
                              onTap: () {
                                themeController.randomTheme();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                                width: 40,
                                height: 40,
                                child: Text(
                                  '?',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Material(
                color: Theme.of(context).cardColor,
                child: ExpansionTile(
                  title: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text('font'.tr),
                      ),
                      Text(
                        ThemeController.fontName(themeController.fontIndex),
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                  leading: Icon(
                    Icons.font_download,
                    color: Theme.of(context).accentColor,
                  ),
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (_, i) => Obx(
                        () => RadioListTile<int>(
                          value: i,
                          groupValue: themeController.fontIndex.value,
                          onChanged: (i) {
                            themeController.switchFont(i!);
                          },
                          title: Text(ThemeController.fontName(i)),
                        ),
                      ),
                      itemCount: ThemeController.fontValueList.length,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Material(
                color: Theme.of(context).cardColor,
                child: ExpansionTile(
                  title: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text('language'.tr),
                      ),
                      Text(
                        LocaleController.localeName(
                            localeController.localeIndex.value),
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                  leading: Icon(
                    Icons.public,
                    color: Theme.of(context).accentColor,
                  ),
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (_, i) => Obx(
                        () => RadioListTile<int>(
                          value: i,
                          groupValue: localeController.localeIndex.value,
                          onChanged: (i) {
                            localeController.switchLocale(i!);
                          },
                          title: Text(LocaleController.localeName(i)),
                        ),
                      ),
                      itemCount: LocaleController.localeValueList.length,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// ///
// /// 切换夜间模式
// ///
// _switchDarkMode(context) {
//   if (Get.isPlatformDarkMode) {
//     Global.toast('检测到系统为暗黑模式,已为你自动切换');
//   } else {
//     Provider.of<ThemeModel>(context, listen: false).switchTheme(
//       isDarkMode: Theme.of(context).brightness == Brightness.light,
//     );
//   }
// }
}
