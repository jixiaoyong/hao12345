import 'package:flutter/material.dart';

import 'theme.dart';

/// @description: TODO
/// @author: jixiaoyong
/// @email: jixiaoyong1995@gmail.com
/// @date: 2023/3/20
class ThemeManager {
  static final ThemeManager instance = ThemeManager._();

  ThemeManager._();

  ThemeData _themeData = kLightTheme;

  ThemeData get themeData => _themeData;

  void setTheme(ThemeData themeData) {
    _themeData = themeData;
  }
}
