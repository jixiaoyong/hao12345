import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:hao12345/bean/search_engine.dart';

/// fontSize : 1
/// searchEngine : 0

class LocalSettingConfig {
  static const String DEF_ICON =
      "https://avatars.githubusercontent.com/u/18367427?v=4";

  LocalSettingConfig({
    this.fontSize,
    this.searchEngine,
    this.searchIcon,
    this.isDarkTheme,
  });

  LocalSettingConfig.DEAFULT() {
    fontSize = 15.0;
    searchEngine = SearchEngine.Google;
    searchIcon = DEF_ICON;
    isDarkTheme = null; // 默认和系统保持一致
  }

  factory LocalSettingConfig.fromJsonStrOrNull(String? jsonStr) {
    if (jsonStr == null || jsonStr.isEmpty) {
      return LocalSettingConfig.DEAFULT();
    }
    try {
      final jsonMap = json.decode(jsonStr);
      return LocalSettingConfig.fromJson(jsonMap);
    } catch (e) {
      debugPrint(e.toString());
      return LocalSettingConfig.DEAFULT();
    }
  }

  LocalSettingConfig.fromJson(dynamic json) {
    fontSize = json['fontSize'] ?? 15;
    searchEngine = SearchEngine.values[json['searchEngine'] ?? 0];
    searchIcon = json['searchIcon'];
    isDarkTheme = json['isDarkTheme'];
  }

  double? fontSize;
  SearchEngine? searchEngine;
  String? searchIcon;
  bool? isDarkTheme;

  LocalSettingConfig copyWith({
    double? fontSize,
    SearchEngine? searchEngine,
    String? searchIcon,
    bool? isDarkTheme,
  }) =>
      LocalSettingConfig(
        fontSize: fontSize ?? this.fontSize,
        searchEngine: searchEngine ?? this.searchEngine,
        searchIcon: searchIcon ?? this.searchIcon,
        isDarkTheme: isDarkTheme,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fontSize'] = fontSize;
    map['searchEngine'] = searchEngine?.index;
    map['searchIcon'] = searchIcon;
    map['isDarkTheme'] = isDarkTheme;
    return map;
  }
}
