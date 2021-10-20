import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluzz/common/widget.dart';
import 'package:fluzz/controller/splash.dart';
import 'package:get/get.dart';

///
/// 开屏页面
///
/// @author zzzz1997
/// @created_time 20200911
///
class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Widgets.assetUrl('ic_fluzz.svg'),
            width: 200,
            height: 200,
          ),
          SizedBox(
            width: Get.width,
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
}
