import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'bean/local_setting_config.dart';
import 'component/my_home_page.dart';
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        localSettingConfig: localConfig,
      ),
    );
  }
}
