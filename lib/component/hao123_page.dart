import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hao12345/bean/local_setting_config.dart';
import 'package:hao12345/bean/search_engine.dart';
import 'package:hao12345/component/settings_dialog.dart';
import 'package:hao12345/utils/local_storage.dart';
import 'package:hao12345/utils/some_keys.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bean/all_urls_bean.dart';
import '../net/network_helper.dart';
import '../theme/theme.dart';
import '../theme/theme_manager.dart';
import '../utils/logger.dart';
import 'loaded_body.dart';
import 'loading_body_widget.dart';

/// author: jixiaoyong
/// email: jixiaoyong1995@gmail.com
/// date: 2022/3/28
/// description: hao123主页
class Hao123Page extends StatefulWidget {
  LocalSettingConfig localSettingConfig;

  Hao123Page({
    Key? key,
    required this.localSettingConfig,
  }) : super(key: key);

  @override
  State<Hao123Page> createState() => _Hao123PageState();
}

class _Hao123PageState extends State<Hao123Page> with WidgetsBindingObserver {
  AllUrlsBean? allUrlsBean;

  late TextEditingController _textController;

  @override
  initState() {
    super.initState();
    _textController = TextEditingController();
    init();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _toggleTheme();
    });
    WidgetsBinding.instance.addObserver(this);
  }

  void _toggleTheme() {
    setState(() {
      // 优先读取本地的主题设置
      var isDarkModel = widget.localSettingConfig.isDarkTheme ??
          SchedulerBinding.instance.window.platformBrightness ==
              Brightness.dark;

      if (isDarkModel) {
        ThemeManager.instance.setTheme(kDarkTheme);
      } else {
        ThemeManager.instance.setTheme(kLightTheme);
      }
    });
  }

  void init() {
    NetworkHelper.INSTANCE.apiService.getClasses("hao123").then((value) {
      setState(() {
        allUrlsBean = value;
      });
    }).onError((error, stackTrace) {
      Logger.d(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var isSmallWidthScreen = kIsWeb && screenWidth <= 400;
    var inputMethodPadding = screenWidth / 20;
    if (isSmallWidthScreen) {
      inputMethodPadding = 0;
    }

    var iconSize = screenWidth / 8;
    if (iconSize < 80) {
      iconSize = 80;
    }

    var themeData = ThemeManager.instance.themeData;

    return Scaffold(
      backgroundColor: themeData.scaffoldBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                isSmallWidthScreen ? 0 : (screenWidth / 6),
                0,
                isSmallWidthScreen ? 0 : (screenWidth / 6),
                kIsWeb ? 150 : 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //icon
                ClipRRect(
                  borderRadius: BorderRadius.circular(iconSize),
                  child: Image.network(
                    widget.localSettingConfig.searchIcon ??
                        LocalSettingConfig.DEF_ICON,
                    height: iconSize,
                    width: iconSize,
                    fit: BoxFit.cover,
                  ),
                ),
                // search box
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: inputMethodPadding, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(50)),
                            height: 50,
                            child: Row(
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: isSmallWidthScreen ? 10 : 20),
                                  child: TextField(
                                    controller: _textController,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: themeData.primaryColor),
                                    decoration: const InputDecoration(
                                        border: InputBorder.none),
                                    onSubmitted: (String value) {
                                      if (value.isEmpty) {
                                        return;
                                      }
                                      launch(
                                          "${widget.localSettingConfig.searchEngine?.url}${value}");
                                    },
                                  ),
                                )),
                                if (!isSmallWidthScreen)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: DropdownButton(
                                        items: SearchEngine.values.map((e) {
                                          return DropdownMenuItem(
                                            value: e,
                                            child: Text(e.name),
                                          );
                                        }).toList(),
                                        value: widget
                                            .localSettingConfig.searchEngine,
                                        style: TextStyle(
                                            color: themeData.primaryColor),
                                        onChanged: (e) {
                                          setState(() {
                                            widget.localSettingConfig
                                                    .searchEngine =
                                                e as SearchEngine?;
                                          });
                                          LocalStorage.setItem(
                                              SomeKeys.SETTING_CONFIG,
                                              json.encode(
                                                  widget.localSettingConfig));
                                        },
                                        underline: Container()),
                                  )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // navigation website urls
                allUrlsBean == null
                    ? const LoadingBodyWidget()
                    : LoadedBody(
                        allUrlsBean: allUrlsBean!,
                        isSmallWidthScreen: isSmallWidthScreen,
                        themeData: themeData,
                        fontSize: widget.localSettingConfig.fontSize)
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var searchIcon = widget.localSettingConfig.searchIcon;

          showDialog(
              context: context,
              builder: (context) {
                var fontSize = widget.localSettingConfig.fontSize!;
                var curTheme = ThemeManager.instance.themeData;
                var isDarkTheme = Brightness.dark == curTheme.brightness;
                return SettingsDialog(
                    backgroundColor: themeData.scaffoldBackgroundColor,
                    fontSize: fontSize,
                    searchIcon: searchIcon,
                    isDarkTheme: isDarkTheme,
                    updateFontSize: (fontSize) {
                      setState(() {
                        widget.localSettingConfig.fontSize = fontSize;
                      });
                      LocalStorage.setItem(SomeKeys.SETTING_CONFIG,
                          json.encode(widget.localSettingConfig));
                    },
                    updateSearchIcon: (searchIcon) {
                      Logger.d("searchIcon输入头像地址 $searchIcon");

                      setState(() {
                        widget.localSettingConfig.searchIcon = searchIcon;
                      });
                      LocalStorage.setItem(SomeKeys.SETTING_CONFIG,
                          json.encode(widget.localSettingConfig));

                      Navigator.of(context).pop();
                    },
                    updateDarkModel: (isDarkModel) {
                      widget.localSettingConfig.isDarkTheme = isDarkModel;
                      LocalStorage.setItem(SomeKeys.SETTING_CONFIG,
                          json.encode(widget.localSettingConfig));
                      _toggleTheme();
                    });
              });
        },
        child: const Icon(Icons.settings),
      ),
    );
  }

  @override
  void didChangePlatformBrightness() {
    _toggleTheme();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
