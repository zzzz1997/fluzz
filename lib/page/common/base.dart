import 'package:flutter/material.dart' hide WidgetBuilder;
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluzz/common/global.dart';
import 'package:fluzz/common/widget.dart';
import 'package:fluzz/controller/base.dart';
import 'package:fluzz/page/widget/loading.dart';
import 'package:get/get.dart';

///
/// 组件列表构建器
///
typedef SliverWidgetsBuilder = List<Widget> Function();

///
/// 子组件构建器
///
typedef ChildBuilder = Widget Function(Widget child);

///
/// 基础加载
///
/// @author zhouqin
/// @created_time 20210416
///
mixin BaseLoad<T extends BaseLoadController> on StatelessWidget {
  // 刷新控件
  final _refreshController = EasyRefreshController();

  // 控制器对象
  T get controller;

  // 是否需要刷新
  bool get needRefresh;

  // 状态控制器
  late T c;

  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    try {
      c = Get.find<T>();
    } catch (e) {
      c = Get.put(controller, tag: controller.tag);
      if (!needRefresh) {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          _onRefresh();
        });
      }
    }
    return Widgets.size();
  }

  ///
  /// 构建加载
  ///
  Widget buildLoad(WidgetBuilder builder,
      {ChildBuilder? refreshBuilder,
      ChildBuilder? childBuilder,
      bool center = false}) {
    return Obx(() {
      Widget widget = needRefresh
          ? Builder(
              builder: (_) => builder(),
            )
          : LoadingView(
              status: c.status.value,
              builder: builder,
              isEmpty: c.status.value == ControllerStatus.loading,
              onErrorTap: callRefresh,
            );
      if (childBuilder != null) {
        widget = childBuilder(widget);
      }
      if (needRefresh) {
        widget = EasyRefresh(
          controller: _refreshController,
          firstRefresh: true,
          emptyWidget: c.status.value == ControllerStatus.loading
              ? LoadingView.load()
              : c.status.value == ControllerStatus.error
                  ? Center(
                      child: Widgets.gesture(
                        onTap: callRefresh,
                        child: LoadingView.prompt(false),
                      ),
                    )
                  : center
                      ? widget
                      : null,
          header: MaterialHeader(),
          footer: MaterialFooter(),
          onRefresh: _onRefresh,
          bottomBouncing: false,
          child: center ? Widgets.size() : widget,
        );
      }
      if (refreshBuilder != null) {
        widget = refreshBuilder(widget);
      }
      return widget;
    });
  }

  ///
  /// 刷新事件
  ///
  Future<void> _onRefresh() async {
    try {
      await c.reload();
    } catch (e) {
      Global.toast(e.toString());
    }
  }

  ///
  ///
  /// 刷新事件
  callRefresh() {
    _refreshController.callRefresh();
  }

  ///
  /// 销毁事件
  ///
  refreshDispose() {
    _refreshController.dispose();
  }
}

///
/// 基础刷新
///
mixin BaseRefresh<T extends BaseRefreshController> on StatelessWidget {
  // 刷新控件
  final _refreshController = EasyRefreshController();

  // 控制器对象
  T get controller;

  // 状态控制器
  late T c;

  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    c = Get.put(controller, tag: controller.tag);
    return Widgets.size();
  }

  ///
  /// 构建刷新
  ///
  Widget buildRefresh(WidgetBuilder builder,
      {bool loadMore = true,
      bool? bottomBouncing,
      SliverWidgetsBuilder? forward,
      SliverWidgetsBuilder? backward,
      ChildBuilder? refreshBuilder}) {
    return Obx(() {
      Widget refresh = EasyRefresh.custom(
        controller: _refreshController,
        firstRefresh: true,
        emptyWidget: c.status.value == ControllerStatus.loading
            ? LoadingView.load()
            : c.status.value == ControllerStatus.error
                ? Center(
                    child: Widgets.gesture(
                      onTap: callRefresh,
                      child: LoadingView.prompt(false),
                    ),
                  )
                : c.data.isEmpty
                    ? Center(
                        child: LoadingView.prompt(true),
                      )
                    : null,
        header: MaterialHeader(),
        footer: MaterialFooter(
          enableInfiniteLoad: !c.noMore.value,
        ),
        onRefresh: () async {
          await _loadData(true);
        },
        onLoad: loadMore
            ? () async {
                await _loadData(false);
              }
            : null,
        bottomBouncing: bottomBouncing ?? loadMore,
        slivers: <Widget>[
          if (forward != null) ...forward(),
          RefreshLoadingView(
            status: c.status.value,
            isEmpty: c.data.isEmpty,
            builder: builder,
            onErrorTap: callRefresh,
          ),
          if (backward != null) ...backward(),
        ],
      );
      if (refreshBuilder != null) {
        refresh = refreshBuilder(refresh);
      }
      return refresh;
    });
  }

  ///
  /// 加载数据
  ///
  _loadData(bool isRefresh) async {
    try {
      if (!isRefresh && c.data.isNotEmpty) {
        await c.loadMore();
      } else {
        await c.reload();
      }
    } catch (e) {
      Global.toast(e.toString());
    }
  }

  ///
  ///
  /// 刷新事件
  callRefresh() {
    _refreshController.callRefresh();
  }

  ///
  /// 销毁事件
  ///
  refreshDispose() {
    _refreshController.dispose();
  }
}
