import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

///
/// 公共工具类
///
/// @author zhouqin
/// @created_time 20210810
///
class CommonUtil {
  // 通道
  static const _channel = MethodChannel('flutter_common');

  ///
  /// md5加密
  ///
  static String md5Encode(String text) {
    final content = utf8.encode(text);
    final digest = md5.convert(content);
    return hex.encode(digest.bytes).toUpperCase();
  }

  ///
  /// 保留小数（去尾法）
  ///
  static String fixed(num number, {int fractionDigits = 2}) {
    var string = number.toString();
    var length = string.lastIndexOf('.');
    if (length < 0 || string.length - length - 1 < fractionDigits) {
      return number.toStringAsFixed(fractionDigits);
    } else {
      return string.substring(0, length + fractionDigits + 1);
    }
  }

  ///
  /// 安装应用
  ///
  static installApk(String path) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      _channel.invokeMethod('installApk', {
        'path': path,
      });
    }
  }
}
