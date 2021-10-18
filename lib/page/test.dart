import 'package:flutter/material.dart';
import 'package:fluzz/common/widget.dart';
import 'package:fluzz/controller/test.dart';
import 'package:fluzz/page/common/base.dart';
import 'package:get/get.dart';

///
/// 测试加载页面
///
/// @author zhouqin
/// @created_time 20210416
///
// ignore: must_be_immutable
class TestLoadPage extends StatelessWidget with BaseLoad<TestLoadController> {
  TestLoadPage({Key? key}) : super(key: key);

  @override
  TestLoadController get controller => TestLoadController();

  @override
  bool get needRefresh => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('appName'.tr),
      ),
      body: buildLoad(() {
        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Widgets.text(c.data.value!.username, size: 16),
            Obx(() {
              return Widgets.text(c.count.toString(), size: 16);
            }),
            ElevatedButton(
              onPressed: c.increment,
              child: Widgets.text('increase'.tr, size: 18),
            ),
          ],
        );
      }, center: true),
    );
  }
}

///
/// 测试刷新页面
///
// ignore: must_be_immutable
class TestRefreshPage extends StatelessWidget
    with BaseRefresh<TestRefreshController> {
  TestRefreshPage({Key? key}) : super(key: key);

  @override
  TestRefreshController get controller => TestRefreshController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('appName'.tr),
      ),
      body: buildRefresh(
        () => SliverPadding(
          padding: Widgets.symmetricEdge(
            horizontal: 10,
            vertical: 10,
          ),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, i) => Card(
                child: Widgets.symmetric(
                  horizontal: 15,
                  vertical: 20,
                  child: Widgets.text(c.data[i].username),
                ),
              ),
              childCount: c.data.length,
            ),
          ),
        ),
      ),
    );
  }
}
