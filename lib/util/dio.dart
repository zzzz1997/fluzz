import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluzz/common/constant.dart';
import 'package:fluzz/common/data.dart';
import 'package:fluzz/common/global.dart';
import 'package:fluzz/main.dart';

///
/// dio工具类
///
/// @author zhouqin
/// @created_time 20210810
///
class DioUtil {
  // 获取dio
  static Dio get dio => _getDio();

  // dio实例
  static Dio? _dio;

  ///
  /// 获取dio单例
  ///
  static Dio _getDio() {
    _dio ??= Dio(BaseOptions(
      connectTimeout: 10000,
      receiveTimeout: 10000,
    ));
    _dio!.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['token'] = Data.token;
        handler.next(options);
      },
    ));
    return _dio!;
  }

  ///
  /// get请求
  ///
  static Future<dynamic> get(url,
      {Map<String, dynamic>? query, bool debug = false}) async {
    try {
      query ??= {};
      query['t'] = DateTime.now().millisecondsSinceEpoch;
      if (debug) {
        Global.logger.d('GET: ${Constant.server}$url');
        Global.logger.d(query);
      }
      Response response = await dio.get(
        Constant.server + url,
        queryParameters: query,
      );
      if (debug) {
        Global.logger.d('GET: ${Constant.server}$url -END');
        Global.logger.d(response.data);
      }
      if (response.data['code'] == 1) {
        return (response.data['data'] is Map && response.data['data'].isEmpty)
            ? response.data['message']
            : response.data['data'];
      } else {
        if (response.data['code'] == -2) {
          Global.eventBus.fire(ErrorTokenEvent());
        }
        throw response.data['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// post请求
  ///
  static Future<dynamic> post(url,
      {Map<String, dynamic>? data, bool debug = false}) async {
    try {
      data ??= {};
      data['t'] = DateTime.now().millisecondsSinceEpoch;
      if (debug) {
        Global.logger.d('POST: ${Constant.server}$url');
        Global.logger.d(jsonEncode(data));
      }
      Response response = await dio.post(
        Constant.server + url,
        data: FormData.fromMap(data),
      );
      if (debug) {
        Global.logger.d('POST: ${Constant.server}$url -END');
        Global.logger.d(response.data);
      }
      if (response.data['code'] == 1) {
        return (response.data['data'] is Map && response.data['data'].isEmpty)
            ? response.data['message']
            : response.data['data'];
      } else {
        if (response.data['code'] == -2) {
          Global.eventBus.fire(ErrorTokenEvent());
        }
        throw response.data['message'];
      }
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.connectTimeout) {
        throw '网络开小差了';
      }
      rethrow;
    }
  }

  ///
  /// 下载文件
  ///
  static Future<Response> download(
      String url, String path, ProgressCallback onReceiveProgress) async {
    try {
      return await dio.download(url, path,
          onReceiveProgress: onReceiveProgress);
    } catch (e) {
      Global.logger.e(e);
      rethrow;
    }
  }
}
