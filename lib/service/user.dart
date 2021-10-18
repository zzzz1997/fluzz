import 'package:dart_mock/dart_mock.dart' as mock;
import 'package:fluzz/controller/locale.dart';
import 'package:fluzz/entity/user.dart';
import 'package:get/get.dart';

///
/// 用户服务
///
/// @author zhouqin
/// @created_time 20210416
///
class UserService {
  ///
  /// 获取用户
  ///
  static Future<User> getUser() async {
    await Future.delayed(const Duration(seconds: 1));
    final controller = Get.find<LocaleController>();
    // throw 'error';
    return User(controller.localeIndex.value == 0 ? mock.cname() : mock.name(),
        mock.dateTime());
  }

  ///
  /// 获取用户列表
  ///
  static Future<List<User>> getUserList(page) async {
    await Future.delayed(const Duration(seconds: 1));
    final controller = Get.find<LocaleController>();
    final length = page == 1
        ? 10
        : page == 2
            ? 5
            : 0;
    List<User> users = [];
    for (var i = 0; i < length; i++) {
      users.add(User(
          controller.localeIndex.value == 0 ? mock.cname() : mock.name(),
          mock.dateTime()));
    }
    // throw 'error';
    return users;
  }
}
