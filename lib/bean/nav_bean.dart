import 'package:freezed_annotation/freezed_annotation.dart';

part 'nav_bean.freezed.dart';
part 'nav_bean.g.dart';

/// name : "每个 Java 程序员必备的 8 个开发工具"
/// url : "http://google.com"
/// pubTimestamp : 1435541999
/// createdAt : "2015-06-29T01:39:35.931Z"
/// updatedAt : "2015-06-29T01:39:35.931Z"
/// objectId : "558e203232060308e3eb36c"
@freezed
abstract class NavBean with _$NavBean {
  const factory NavBean({
    String? name,
    String? url,
    int? pubTimestamp,
    String? createdAt,
    String? updatedAt,
    String? objectId,
  }) = _NavBean;

  factory NavBean.fromJson(Map<String, dynamic> json) =>
      _$NavBeanFromJson(json);
}
