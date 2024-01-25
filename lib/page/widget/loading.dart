import 'package:flutter/material.dart' hide WidgetBuilder;
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluzz/common/widget.dart';
import 'package:fluzz/controller/base.dart';
import 'package:get/get.dart';

// 加载宽度
const loadingWidth = 27.0;

///
/// 组件构建器
///
typedef WidgetBuilder = Widget Function();

///
/// 加载组件
///
/// @author zhouqin
/// @created_time 20210416
///
// ignore: must_be_immutable
class LoadingView extends StatelessWidget {
  LoadingView(
      {required this.status,
      required this.builder,
      required this.isEmpty,
      this.onErrorTap,
      this.empty,
      this.error,
      this.loading,
      Key? key})
      : super(key: key) {
    empty ??= prompt(true);
    error ??= prompt(false);
  }

  // 状态
  final ControllerStatus status;

  // 子组件
  final WidgetBuilder builder;

  // 数据是否为空
  final bool isEmpty;

  // 请求失败点击事件
  final GestureTapCallback? onErrorTap;

  // 空数据组件
  Widget? empty;

  // 错误布局
  Widget? error;

  // 加载界面
  final Widget? loading;

  @override
  Widget build(BuildContext context) {
    return status == ControllerStatus.loading && isEmpty
        ? loading ??
            Center(
              child: Widgets.all(
                10,
                child: Widgets.size(
                  width: loadingWidth,
                  height: loadingWidth,
                  child: Widgets.circle(),
                ),
              ),
            )
        : status == ControllerStatus.done
            ? Center(
                child: isEmpty ? empty : builder(),
              )
            : Widgets.gesture(
                onTap: onErrorTap,
                child: Center(
                  child: error,
                ),
              );
  }

  ///
  /// 提示组件
  ///
  static Widget prompt(empty) => Widgets.text(
        empty ? '暂无记录' : '加载错误',
      );

  ///
  /// 加载组件
  ///
  static Widget load() => Center(
        child: Widgets.all(
          10,
          child: Widgets.size(
            width: loadingWidth,
            height: loadingWidth,
            child: Widgets.circle(),
          ),
        ),
      );
}

///
/// 刷新加载组件
///
// ignore: must_be_immutable
class RefreshLoadingView extends StatelessWidget {
  RefreshLoadingView(
      {required this.status,
      required this.builder,
      required this.isEmpty,
      this.onErrorTap,
      this.empty,
      this.error,
      this.loading,
      Key? key})
      : super(key: key) {
    empty ??= LoadingView.prompt(true);
    error ??= LoadingView.prompt(false);
  }

  // 状态
  final ControllerStatus status;

  // 子组件
  final WidgetBuilder builder;

  // 数据是否为空
  final bool isEmpty;

  // 请求失败点击事件
  final GestureTapCallback? onErrorTap;

  // 空数据组件
  Widget? empty;

  // 错误布局
  Widget? error;

  // 加载界面
  final Widget? loading;

  @override
  Widget build(BuildContext context) {
    return status == ControllerStatus.loading && isEmpty
        ? loading ??
            SliverToBoxAdapter(
              child: Center(
                child: Widgets.all(
                  10,
                  child: Widgets.size(
                    width: loadingWidth,
                    height: loadingWidth,
                    child: Widgets.circle(),
                  ),
                ),
              ),
            )
        : status == ControllerStatus.done
            ? isEmpty
                ? _EmptyWidget(
                    child: empty!,
                  )
                : builder()
            : _EmptyWidget(
                child: Widgets.gesture(
                  onTap: onErrorTap,
                  child: error,
                ),
              );
  }
}

///
/// 空视图组件
///
class _EmptyWidget extends StatelessWidget {
  const _EmptyWidget({required this.child});

  // 子组件
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(_EmptyController());
    return Obx(
      () => controller.size.value.width == 0
          ? _SliverEmpty(
              axisDirectionNotifier: controller.axisDirectionNotifier,
              child: LayoutBuilder(
                builder: (_, constraints) {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    controller.size(
                        Size(constraints.maxWidth, constraints.maxHeight));
                  });
                  return Widgets.size();
                },
              ))
          : SliverToBoxAdapter(
              child: Container(
                width: controller.size.value.width,
                height: controller.size.value.height,
                alignment: Alignment.center,
                child: child,
              ),
            ),
    );
  }
}

///
/// 空组件控制器
///
class _EmptyController extends GetxController {
  // 列表方向
  final axisDirectionNotifier =
      ValueNotifier<AxisDirection>(AxisDirection.down);

  // 组件大小
  var size = const Size(0, 0).obs;

  @override
  void onClose() {
    axisDirectionNotifier.dispose();
    super.onClose();
  }
}

///
/// 空视图组件
///
class _SliverEmpty extends SingleChildRenderObjectWidget {
  const _SliverEmpty({
    required Widget child,
    required this.axisDirectionNotifier,
  }) : super(child: child);

  // 列表方向
  final ValueNotifier<AxisDirection> axisDirectionNotifier;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderSliverEmpty(
      axisDirectionNotifier: axisDirectionNotifier,
    );
  }
}

///
/// 空视图组件渲染器
///
class _RenderSliverEmpty extends RenderSliverSingleBoxAdapter {
  _RenderSliverEmpty({
    required this.axisDirectionNotifier,
  });

  // 列表方向
  final ValueNotifier<AxisDirection> axisDirectionNotifier;

  // 获取子组件大小
  double get _childSize => constraints.axis == Axis.vertical
      ? child!.size.height
      : child!.size.width;

  @override
  void performLayout() {
    axisDirectionNotifier.value = constraints.axisDirection;
    child!.layout(
      constraints.asBoxConstraints(
        maxExtent: constraints.remainingPaintExtent,
      ),
      parentUsesSize: true,
    );
    geometry = SliverGeometry(
      paintExtent: constraints.remainingPaintExtent,
      maxPaintExtent: constraints.remainingPaintExtent,
      layoutExtent: constraints.remainingPaintExtent,
    );
  }

  @override
  void paint(PaintingContext paintContext, Offset offset) {
    if (constraints.remainingPaintExtent > 0.0 ||
        constraints.scrollOffset + _childSize > 0) {
      paintContext.paintChild(child!, offset);
    }
  }
}
