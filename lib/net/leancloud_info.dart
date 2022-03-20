import 'dart:convert';

import 'package:crypto/crypto.dart';

/// author: jixiaoyong
/// email: jixiaoyong1995@gmail.com
/// date: 2022/3/20
/// description: todo
class LeanCloudInfo {
  static const String appId = "eiCorogUwe1OdpPG65oSWEsP-MdYXbMMI";
  static const String appKey = "glorq3CiX4j8RNIWf7kq5LBW";
  static const String masterKey = "";

  static getSign() {
    var timestamp = DateTime.now().millisecondsSinceEpoch;
    return md5.convert(utf8.encode(timestamp.toString() + appKey)).toString();
  }
}
