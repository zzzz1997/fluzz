import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/global.dart';
import '../page/home.dart';
import '../page/splash.dart';

///
/// 动画类型
///
enum AnimationType {
  // 无动画
  NO_ANIM,
  // 浅入浅出
  FADE_IN,
  // Android质感
  MATERIAL,
  // IOS风格
  CUPERTINO
}

///
/// 自定义路由
///
/// @author zzzz1997
/// @created_time 20191121
///
class MyRoute {
  // 开屏路由
  static const splash = 'splash';

  // 主页路由
  static const home = 'home';

  ///
  /// 构造路由
  ///
  static Route generateRoute(RouteSettings settings) {
    Map map = settings.arguments;
    AnimationType routeType = map != null
        ? map['routeType'] ?? AnimationType.NO_ANIM
        : AnimationType.NO_ANIM;
    switch (routeType) {
      case AnimationType.NO_ANIM:
        return PageRouteBuilder(
          opaque: false,
          pageBuilder: (_, __, ___) => _buildPage(settings.name, map),
          transitionDuration: Duration(milliseconds: 0),
          transitionsBuilder: (_, __, ___, child) => child,
        );
      case AnimationType.FADE_IN:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => _buildPage(settings.name, map),
          transitionDuration: Duration(milliseconds: 500),
          transitionsBuilder: (_, animation, __, child) => FadeTransition(
            opacity: Tween(begin: 0.1, end: 1.0).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              ),
            ),
            child: child,
          ),
        );
      case AnimationType.MATERIAL:
        return MaterialPageRoute(
          builder: (context) => _buildPage(settings.name, map),
        );
      case AnimationType.CUPERTINO:
        return CupertinoPageRoute(
          builder: (context) => _buildPage(settings.name, map),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for $routeType'),
            ),
          ),
        );
    }
  }

  ///
  /// 根据名称跳转
  ///
  static Future<T> pushNamed<T>(String routeName,
      {AnimationType routeType, Object arguments}) {
    return Global.navigator.pushNamed<T>(routeName,
        arguments: _combineArguments(routeType, arguments));
  }

  ///
  /// 根据名称跳转并移除筛选的路由
  ///
  static Future<T> pushNamedAndRemoveUntil<T>(
      String routeName, RoutePredicate predicate,
      {AnimationType routeType, Object arguments}) {
    return Global.navigator.pushNamedAndRemoveUntil<T>(routeName, predicate,
        arguments: _combineArguments(routeType, arguments));
  }

  ///
  /// 根据名称跳转替换当前页面
  ///
  static Future<T> pushReplacementNamed<T, TO>(String routeName,
      {AnimationType routeType, TO result, Object arguments}) {
    return Global.navigator.pushReplacementNamed<T, TO>(routeName,
        result: result, arguments: _combineArguments(routeType, arguments));
  }

  ///
  /// 根据名称跳转并退出当前页面
  ///
  static Future<T> popAndPushNamed<T, TO>(String routeName,
      {AnimationType routeType, TO result, Object arguments}) {
    return Global.navigator.popAndPushNamed<T, TO>(routeName,
        result: result, arguments: _combineArguments(routeType, arguments));
  }

  ///
  /// 构建页面
  ///
  static Widget _buildPage(String name, Map<String, Object> map) {
    switch (name) {
      case splash:
        return SplashPage();
      case home:
        return HomePage();
      default:
        return Scaffold(
          body: Center(
            child: Text('No route defined for $name'),
          ),
        );
    }
  }

  ///
  /// 组合参数
  ///
  static Object _combineArguments(AnimationType routeType, Object arguments) {
    return {
      'routeType': routeType ?? AnimationType.MATERIAL,
      'arguments': arguments,
    };
  }
}
