import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluzz/common/constant.dart';
import 'package:fluzz/common/global.dart';
import 'package:fluzz/common/route.dart';
import 'package:fluzz/common/translation.dart';
import 'package:fluzz/controller/locale.dart';
import 'package:fluzz/controller/theme.dart';
import 'package:get/get.dart';

///
/// 应用入口
///
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
//  debugPrint = (String message, {int wrapWidth}) => {};
  await Global.init();
  if (GetPlatform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
  runApp(const MyApp());
}

///
/// 主App
///
/// @author zzzz1997
/// @created_time 20191121
///
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Global.eventBus.on<ErrorTokenEvent>().listen((_) {
      Global.toast('登录失效，请重新登录');
      // Get.offAllNamed(MyRoute.login);
    });
    final themeController = Get.find<ThemeController>();
    final localeController = Get.find<LocaleController>();
    return GetMaterialApp(
      title: Constant.title,
      theme: themeController.themeData(),
      locale: localeController.locale,
      translations: FluzzTranslation(),
      getPages: FluzzRoute.routes,
      initialRoute: FluzzRoute.splash,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: GestureDetector(
          onTap: () {
            var focusScope = FocusScope.of(context);
            if (!focusScope.hasPrimaryFocus &&
                focusScope.focusedChild != null) {
              FocusManager.instance.primaryFocus!.unfocus();
            }
          },
          child: BotToastInit()(context, child),
        ),
      ),
      navigatorObservers: [BotToastNavigatorObserver()],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('zh', 'CN'),
      ],
    );
  }
}

///
/// 错误令牌事件
///
class ErrorTokenEvent {}
