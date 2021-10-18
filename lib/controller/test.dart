import 'package:get/get.dart';
import 'package:fluzz/controller/base.dart';
import 'package:fluzz/entity/user.dart';
import 'package:fluzz/service/user.dart';

///
/// 测试加载控制器
///
/// @author zhouqin
/// @created_time 20210416
///
class TestLoadController extends BaseLoadController<User> {
  // 数量
  var count = 0.obs;

  @override
  Future<User> load() async {
    return await UserService.getUser();
  }

  ///
  /// 增加
  ///
  increment() => count++;
}

///
/// 测试刷新控制器
///
class TestRefreshController extends BaseRefreshController<User> {
  @override
  Future<List<User>> load(int page) async {
    return await UserService.getUserList(page);
  }
}
