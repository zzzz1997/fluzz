import 'package:flutter/material.dart';

import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'common/global.dart';
import 'common/route.dart';
import 'generated/l10n.dart';
import 'model/locale.dart';
import 'model/theme.dart';

///
/// 应用入口
///
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
//  debugPrint = (String message, {int wrapWidth}) => {};
  await Global.init();
  runApp(MyApp());
}

///
/// 主App
///
/// @author zzzz1997
/// @created_time 20191121
///
class MyApp extends StatelessWidget {
  // 标题
  static const title = 'fluzz';

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeModel>(
            create: (_) => ThemeModel(),
          ),
          ChangeNotifierProvider<LocaleModel>(
            create: (_) => LocaleModel(),
          ),
        ],
        child: Consumer2<ThemeModel, LocaleModel>(
          builder: (_, themeModel, localeModel, __) => MaterialApp(
            navigatorKey: Global.key,
            title: title,
            theme: themeModel.themeData(),
            darkTheme: themeModel.themeData(platformDarkMode: true),
            locale: localeModel.locale,
            localizationsDelegates: const [
              S.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            onGenerateRoute: MyRoute.generateRoute,
            initialRoute: MyRoute.splash,
          ),
        ),
      ),
    );
  }
}
