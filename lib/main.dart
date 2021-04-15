import 'package:flutter/material.dart';
import 'package:fluzz/page/splash.dart';

import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

import 'package:fluzz/common/translation.dart';
import 'package:fluzz/common/global.dart';
import 'package:fluzz/common/route.dart';

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
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 1)),
      builder: (_, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? MaterialApp(
                  home: SplashPage(),
                )
              : OKToast(
                  child: GetMaterialApp(
                    title: title,
                    getPages: FluzzRoute.routes,
                    initialRoute: FluzzRoute.home,
                    initialBinding: FluzzBinding(),
                    // locale: Locale('zh', 'CN'),
                    translations: FluzzTranslation(),
                  ),
                ),
    );
  }
}
