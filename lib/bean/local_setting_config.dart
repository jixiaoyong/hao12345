import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:hao12345/bean/search_engine.dart';

/// fontSize : 1
/// searchEngine : 0

class LocalSettingConfig {
  LocalSettingConfig({
    this.fontSize,
    this.searchEngine,
  });

  LocalSettingConfig.DEAFULT() {
    fontSize = 15.0;
    searchEngine = SearchEngine.Google;
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
  }

  double? fontSize;
  SearchEngine? searchEngine;

  LocalSettingConfig copyWith({
    double? fontSize,
    SearchEngine? searchEngine,
  }) =>
      LocalSettingConfig(
        fontSize: fontSize ?? this.fontSize,
        searchEngine: searchEngine ?? this.searchEngine,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fontSize'] = fontSize;
    map['searchEngine'] = searchEngine?.index;
    return map;
  }
}
