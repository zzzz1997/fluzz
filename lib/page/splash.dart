import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../common/global.dart';
import '../common/resource.dart';
import '../common/route.dart';

///
/// 开屏页面
///
/// @author zzzz1997
/// @created_time 20200911
///
class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

///
/// 开屏页面状态
///
class _SplashPageState extends State<SplashPage> {
  // 定时器
  Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer(Duration(seconds: 1), () {
      MyRoute.pushReplacementNamed(MyRoute.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            ImageHelper.image('ic_fluzz.svg'),
            width: 200,
            height: 200,
          ),
          SizedBox(
            width: Global.mediaQuery.size.width,
            height: 20,
          ),
          Text(
            'FLUZZ',
            style: TextStyle(
              color: Colors.primaries[6],
              fontSize: 30,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }
}
