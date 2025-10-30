import 'package:flutter/material.dart';

/// @description: TODO
/// @author: jixiaoyong
/// @email: jixiaoyong1995@gmail.com
/// @date: 2023/3/20

final ThemeData kLightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  hoverColor: Colors.blue,
  hintColor: Colors.grey,
  highlightColor: Colors.white,
);

final ThemeData kDarkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.grey,
  hoverColor: Colors.black38,
  scaffoldBackgroundColor: const Color(0xff201F21),
  hintColor: const Color(0xff303031),
  highlightColor: Colors.black,
);
