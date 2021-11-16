import 'package:fluzz/common/global.dart';
import 'package:get/get.dart';

///
/// 模型状态
///
enum ControllerStatus {
  // 加载中
  loading,
  // 完成
  done,
  // 错误
  error
}

///
/// 基础加载控制器
///
/// @author zhouqin
/// @created_time 20210416
///
abstract class BaseLoadController<T> extends GetxController {
  // 状态
  var status = ControllerStatus.loading.obs;

  // 数据
  Rx<T?> data = Rx(null);

  // 标签
  String? tag;

  ///
  /// 加载数据
  ///
  Future<T> load();

  ///
  /// 刷新
  ///
  reload() async {
    status(ControllerStatus.loading);
    try {
      data.value = await load();
      status(ControllerStatus.done);
    } catch (e) {
      status(ControllerStatus.error);
      rethrow;
    }
  }
}

///
/// 基础刷新控制器
///
abstract class BaseRefreshController<T> extends GetxController {
  // 状态
  var status = ControllerStatus.loading.obs;

  // 数据
  var data = RxList<T>();

  // 没有更多
  var noMore = false.obs;

  // 页码
  var _page = 1;

  // 标签
  String? tag;

  ///
  /// 加载数据
  ///
  Future<List<T>> load(int page);

  ///
  /// 刷新
  ///
  reload() async {
    status(ControllerStatus.loading);
    data.clear();
    noMore(false);
    _page = 1;
    try {
      final list = await load(_page);
      if (data.isEmpty) {
        noMore(true);
      }
      data(list);
      status(ControllerStatus.done);
    } catch (e) {
      status(ControllerStatus.error);
      rethrow;
    }
  }

  ///
  /// 加载更多
  ///
  loadMore() async {
    final list = await load(_page + 1);
    if (list.isNotEmpty) {
      data += list;
      _page++;
    } else {
      noMore(true);
      Global.toast('noMore'.tr);
    }
  }
}
