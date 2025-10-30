/// name : "每个 Java 程序员必备的 8 个开发工具"
/// url : "http://google.com"
/// pubTimestamp : 1435541999
/// createdAt : "2015-06-29T01:39:35.931Z"
/// updatedAt : "2015-06-29T01:39:35.931Z"
/// objectId : "558e20cbe4b060308e3eb36c"
class NavBean {
  NavBean({
    this.name,
    this.url,
    this.pubTimestamp,
    this.createdAt,
    this.updatedAt,
    this.objectId,
  });

  NavBean.fromJson(dynamic json) {
    name = json['name'];
    url = json['url'];
    pubTimestamp = json['pubTimestamp'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    objectId = json['objectId'];
  }
  String? name;
  String? url;
  int? pubTimestamp;
  String? createdAt;
  String? updatedAt;
  String? objectId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['url'] = url;
    map['pubTimestamp'] = pubTimestamp;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['objectId'] = objectId;
    return map;
  }
}
