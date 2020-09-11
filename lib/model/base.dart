import 'package:flutter/material.dart';

import '../model/common.dart';

///
/// 加载数据方法
///
typedef LoadFunction = Future<void> Function();

///
/// 模型基类
///
/// @author zzzz1997
/// @created_time 20200327
///
class BaseModel extends ChangeNotifier {
  // 是否销毁
  var _disposed = false;

  // 状态
  CommonStatus _status = CommonStatus.LOADING;

  // 获取状态
  CommonStatus get status => _status;

  ///
  /// 加载数据
  ///
  Future<void> load(LoadFunction function, {bool loading = true}) async {
//    if (loading && _status) {
//      _status = CommonStatus.LOADING;
//      notifyListeners();
//    }
    try {
      await function();
      _status = CommonStatus.DONE;
      notifyListeners();
    } catch (e) {
      _status = CommonStatus.ERROR;
      notifyListeners();
      throw e;
    }
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    debugPrint('model dispose -->$runtimeType');
    super.dispose();
  }
}
