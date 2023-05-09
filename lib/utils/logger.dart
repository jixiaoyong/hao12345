import 'package:flutter/widgets.dart';

/// @description: 日志工具
/// @author: jixiaoyong
/// @email: jixiaoyong1995@gmail.com
/// @date: 2023/3/20
class Logger {
  static d(Object? msg) {
    if (null != msg) {
      debugPrint(msg.toString());
    }
  }
}
