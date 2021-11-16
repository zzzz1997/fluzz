import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

///
/// 用户实体
///
/// @author zhouqin
/// @created_time 20210416
///
@JsonSerializable()
class User {
  User(this.username, this.time);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  // 用户名
  String username;

  // 时间
  @JsonKey(fromJson: timeFromJson, toJson: timeToJson)
  DateTime time;

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

  ///
  /// json转时间
  ///
  static DateTime timeFromJson(int? time) =>
      DateTime.fromMillisecondsSinceEpoch(time == null ? 0 : time * 1000);

  ///
  /// 时间转json
  ///
  static int? timeToJson(DateTime time) => time.millisecondsSinceEpoch;
}
