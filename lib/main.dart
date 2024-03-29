import 'package:flutter/material.dart';

import 'bean/local_setting_config.dart';
import 'component/hao123_page.dart';
import 'utils/local_storage.dart';
import 'utils/some_keys.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localConfigStr = LocalStorage.getItem(SomeKeys.SETTING_CONFIG);
    var localConfig = LocalSettingConfig.fromJsonStrOrNull(localConfigStr);

    return MaterialApp(
      title: "常用网址导航",
      home: Hao123Page(
        localSettingConfig: localConfig,
      ),
    );
  }
}
