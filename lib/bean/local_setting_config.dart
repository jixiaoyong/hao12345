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
  });

  LocalSettingConfig.DEAFULT() {
    fontSize = 15.0;
    searchEngine = SearchEngine.Google;
    searchIcon = DEF_ICON;
  }

  factory LocalSettingConfig.fromJsonStrOrNull(String? jsonStr) {
    var jsonMap;
    try {
      jsonMap = json.decode(jsonStr!);
    } catch (e) {
      debugPrint(e.toString());
    }
    if (jsonMap == null) {
      return LocalSettingConfig.DEAFULT();
    } else {
      return LocalSettingConfig.fromJson(jsonMap);
    }
  }

  LocalSettingConfig.fromJson(dynamic json) {
    fontSize = json['fontSize'] ?? 15;
    searchEngine = SearchEngine.values[json['searchEngine'] ?? 0];
    searchIcon = json['searchIcon'];
  }

  double? fontSize;
  SearchEngine? searchEngine;
  String? searchIcon;

  LocalSettingConfig copyWith({
    double? fontSize,
    SearchEngine? searchEngine,
    String? searchIcon,
  }) =>
      LocalSettingConfig(
        fontSize: fontSize ?? this.fontSize,
        searchEngine: searchEngine ?? this.searchEngine,
        searchIcon: searchIcon ?? this.searchIcon,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fontSize'] = fontSize;
    map['searchEngine'] = searchEngine?.index;
    map['searchIcon'] = searchIcon;
    return map;
  }
}
