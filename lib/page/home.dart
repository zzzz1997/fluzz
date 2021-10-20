import 'package:flutter/material.dart';
import 'package:fluzz/controller/home.dart';
import 'package:fluzz/page/fragment/setting.dart';
import 'package:fluzz/page/test.dart';
import 'package:get/get.dart';

///
/// 主页面
///
/// @author zzzz1997
/// @created_time 20200911
///
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Obx(
      () => Scaffold(
        body: [
          TestLoadPage(),
          TestRefreshPage(),
          const SettingFragment()
        ][controller.index.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.index.value,
          onTap: controller.onTap,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: "load".tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.refresh),
              label: "refresh".tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: "setting".tr,
            ),
          ],
        ),
      ),
    );
  }
}
