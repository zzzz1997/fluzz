import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/global.dart';
import '../common/resource.dart';
import '../model/locale.dart';
import '../model/theme.dart';

///
/// 主页面
///
/// @author zzzz1997
/// @created_time 20200911
///
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

///
/// 主页面状态
///
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Global.s.appName),
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
                  title: Text(Global.s.darkMode),
                  onTap: () {
                    _switchDarkMode(context);
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
                  title: Text(Global.s.colorTheme),
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
                                        Provider.of<ThemeModel>(context,
                                                listen: false)
                                            .switchTheme(color: color);
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
                                Provider.of<ThemeModel>(context, listen: false)
                                    .switchRandomTheme();
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
                        child: Text(Global.s.font),
                      ),
                      Text(
                        ThemeModel.fontName(
                            Provider.of<ThemeModel>(context, listen: false)
                                .fontIndex),
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
                      itemBuilder: (_, i) {
                        var model =
                            Provider.of<ThemeModel>(context, listen: false);
                        return RadioListTile(
                          value: i,
                          groupValue: model.fontIndex,
                          onChanged: (i) {
                            model.switchFont(i);
                          },
                          title: Text(ThemeModel.fontName(i)),
                        );
                      },
                      itemCount: ThemeModel.fontValueList.length,
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
                        child: Text(Global.s.language),
                      ),
                      Text(
                        LocaleModel.localeName(
                            Provider.of<LocaleModel>(context).localeIndex),
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
                      itemBuilder: (_, i) {
                        var model = Provider.of<LocaleModel>(context);
                        return RadioListTile(
                          value: i,
                          groupValue: model.localeIndex,
                          onChanged: (i) {
                            model.switchLocale(i);
                          },
                          title: Text(LocaleModel.localeName(i)),
                        );
                      },
                      itemCount: LocaleModel.localeValueList.length,
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

  ///
  /// 切换夜间模式
  ///
  _switchDarkMode(context) {
    if (Global.mediaQuery.platformBrightness == Brightness.dark) {
      Global.toast('检测到系统为暗黑模式,已为你自动切换');
    } else {
      Provider.of<ThemeModel>(context, listen: false).switchTheme(
        isDarkMode: Theme.of(context).brightness == Brightness.light,
      );
    }
  }
}
