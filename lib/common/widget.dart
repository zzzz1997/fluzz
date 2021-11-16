import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

///
/// 组件类
///
/// @author zhouqin
/// @created_time 20210416
///
class Widgets {
  ///
  /// 图片链接
  ///
  static String assetUrl(String name) => 'asset/image/$name';

  ///
  /// 文本组件
  ///
  static Text text(String text,
          {double? size,
          Color? color,
          TextAlign? textAlign,
          int? maxLines,
          TextOverflow? overflow,
          FontWeight? weight}) =>
      Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: weight,
        ),
        maxLines: maxLines,
        overflow: overflow,
      );

  ///
  /// 富文本组件
  ///
  static Text richText(List<TextItem> items) => Text.rich(
        TextSpan(
          children: items
              .map((e) => TextSpan(
                    text: e.text,
                    style: TextStyle(
                      color: e.color,
                      fontSize: e.size,
                    ),
                  ))
              .toList(),
        ),
      );

  ///
  /// 大小组件
  ///
  static SizedBox size({double? width, double? height, Widget? child}) =>
      SizedBox(
        width: width,
        height: height,
        child: child,
      );

  ///
  /// 宽度组件
  ///
  static SizedBox width(double width, {Widget? child}) =>
      size(width: width, child: child);

  ///
  /// 高度组件
  ///
  static SizedBox height(double height, {Widget? child}) =>
      size(height: height, child: child);

  ///
  /// 正方形组件
  ///
  static SizedBox square(double side, {Widget? child}) =>
      size(width: side, height: side, child: child);

  ///
  /// 轴边距组件
  ///
  static Padding symmetric(
          {double vertical = 0.0, double horizontal = 0.0, Widget? child}) =>
      ltrb(horizontal, vertical, horizontal, vertical, child: child);

  ///
  /// 边距组件
  ///
  static Padding all(double padding, {Widget? child}) =>
      ltrb(padding, padding, padding, padding, child: child);

  ///
  /// 边距组件
  ///
  static Padding only(
          {double left = 0.0,
          double top = 0.0,
          double right = 0.0,
          double bottom = 0.0,
          Widget? child}) =>
      ltrb(left, top, right, bottom, child: child);

  ///
  /// 边距组件
  ///
  static Padding ltrb(double left, double top, double right, double bottom,
          {Widget? child}) =>
      Padding(
        padding: ltrbEdge(left, top, right, bottom),
        child: child,
      );

  ///
  /// 边距
  ///
  static EdgeInsets symmetricEdge(
          {double vertical = 0.0, double horizontal = 0.0}) =>
      ltrbEdge(horizontal, vertical, horizontal, vertical);

  ///
  /// 边距
  ///
  static EdgeInsets allEdge(double padding) =>
      ltrbEdge(padding, padding, padding, padding);

  ///
  /// 边距组件
  ///
  static EdgeInsets onlyEdge(
          {double left = 0.0,
          double top = 0.0,
          double right = 0.0,
          double bottom = 0.0}) =>
      ltrbEdge(left, top, right, bottom);

  ///
  /// 边距
  ///
  static EdgeInsets ltrbEdge(
          double left, double top, double right, double bottom) =>
      EdgeInsets.fromLTRB(left, top, right, bottom);

  ///
  /// 零边距
  ///
  static EdgeInsets get zeroEdge => EdgeInsets.zero;

  ///
  /// 圆形
  ///
  static CircularProgressIndicator circle() => const CircularProgressIndicator(
        strokeWidth: 2,
        // valueColor: const AlwaysStoppedAnimation<Color>(Style.primary),
      );

  ///
  /// 手势
  ///
  static GestureDetector gesture({
    HitTestBehavior behavior = HitTestBehavior.opaque,
    GestureTapCallback? onTap,
    GestureLongPressCallback? onLongPress,
    Widget? child,
  }) =>
      GestureDetector(
        behavior: behavior,
        onTap: onTap,
        onLongPress: onLongPress,
        child: child,
      );

  ///
  /// 本地资源图片
  ///
  static ExtendedImage asset(String name,
          {double? width, double? height, BoxFit? fit, BoxShape? shape}) =>
      ExtendedImage.asset(
        assetUrl(name),
        width: width,
        height: height,
        fit: fit,
        shape: shape,
      );

  ///
  /// 网络图片
  ///
  static ExtendedImage network(String url,
          {double? width, double? height, BoxFit? fit, BoxShape? shape}) =>
      ExtendedImage.network(
        url,
        width: width,
        height: height,
        fit: fit,
        shape: shape,
      );

  ///
  /// 内存图片
  ///
  static ExtendedImage memory(Uint8List bytes,
          {double? width, double? height, BoxFit? fit, BoxShape? shape}) =>
      ExtendedImage.memory(
        bytes,
        width: width,
        height: height,
        fit: fit,
        shape: shape,
      );

  ///
  /// 文件图片
  ///
  static ExtendedImage file(File file,
          {double? width, double? height, BoxFit? fit, BoxShape? shape}) =>
      ExtendedImage.file(
        file,
        width: width,
        height: height,
        fit: fit,
        shape: shape,
      );

  ///
  /// 本地资源图片提供器
  ///
  static AssetImage assetProvider(String name) => AssetImage(assetUrl(name));

  ///
  /// 网络图片提供器
  ///
  static NetworkImage networkProvider(String url) => NetworkImage(url);

  ///
  /// 分割线
  ///
  static Container divider({double height = 1}) => Container(
        height: height,
        color: Colors.grey,
      );
}

///
/// 文本单元
///
class TextItem {
  TextItem(this.text, this.size, {this.color = Colors.black});

  // 文本
  final String text;

  // 大小
  final double size;

  // 颜色
  Color color;
}
