import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/scheduler.dart';
import 'package:hao12345/bean/local_setting_config.dart';
import 'package:hao12345/bean/search_engine.dart';
import 'package:hao12345/utils/local_storage.dart';
import 'package:hao12345/utils/some_keys.dart';
import 'package:url_launcher/url_launcher.dart';

// unused import removed
import '../state/navigation_view_model.dart';
import '../theme/theme.dart';
import '../theme/theme_manager.dart';
import '../utils/logger.dart';
import 'loaded_body.dart';
import '../widgets/ios_modal.dart';

/// author: jixiaoyong
/// email: jixiaoyong1995@gmail.com
/// date: 2022/3/28
/// description: hao123主页
class Hao123Page extends StatefulWidget {
  final LocalSettingConfig localSettingConfig;

  const Hao123Page({
    super.key,
    required this.localSettingConfig,
  });

  @override
  State<Hao123Page> createState() => _Hao123PageState();
}

class _Hao123PageState extends State<Hao123Page> with WidgetsBindingObserver {
  String? loadError;

  late TextEditingController _textController;

  @override
  initState() {
    super.initState();
    _textController = TextEditingController();
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
      appBar: AppBar(
        backgroundColor: themeData.scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.manage_accounts),
            onPressed: () => Navigator.of(context).pushNamed('/manage'),
          ),
        ],
      ),
      body: Center(
        child: Consumer(builder: (context, ref, _) {
          final asyncData = ref.watch(navigationViewModelProvider);
          return SingleChildScrollView(
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
                                        horizontal:
                                            isSmallWidthScreen ? 10 : 20),
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
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Builder(builder: (btnCtx) {
                                            return CupertinoButton(
                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                              minSize: 0,
                                              onPressed: () async {
                                                final overlay = Overlay.of(btnCtx).context.findRenderObject() as RenderBox?;
                                                final btnBox = btnCtx.findRenderObject() as RenderBox?;
                                                if (btnBox == null || overlay == null) return;
                                                final offset = btnBox.localToGlobal(Offset.zero, ancestor: overlay);
                                                final sizeBtn = btnBox.size;
                                                final selected = await showMenu<SearchEngine>(
                                                  context: btnCtx,
                                                  position: RelativeRect.fromLTRB(
                                                    offset.dx,
                                                    offset.dy + sizeBtn.height,
                                                    overlay.size.width - (offset.dx + sizeBtn.width),
                                                    overlay.size.height - (offset.dy + sizeBtn.height),
                                                  ),
                                                  items: SearchEngine.values.map((e) {
                                                    final isSel = widget.localSettingConfig.searchEngine == e;
                                                    return PopupMenuItem<SearchEngine>(
                                                      value: e,
                                                      child: Row(children: [
                                                        if (isSel) const Padding(padding: EdgeInsets.only(right: 6), child: Icon(Icons.check, size: 16)),
                                                        Text(e.name),
                                                      ]),
                                                    );
                                                  }).toList(),
                                                );
                                                if (selected != null) {
                                                  setState(() {
                                                    widget.localSettingConfig.searchEngine = selected;
                                                  });
                                                  LocalStorage.setItem(
                                                    SomeKeys.SETTING_CONFIG,
                                                    json.encode(widget.localSettingConfig),
                                                  );
                                                }
                                              },
                                              child: const Row(children: [
                                                Icon(CupertinoIcons.search),
                                                SizedBox(width: 6),
                                                Text('切换'),
                                              ]),
                                            );
                                          }),
                                          const SizedBox(width: 6),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                            decoration: BoxDecoration(
                                              color: themeData.cardColor,
                                              borderRadius: BorderRadius.circular(16),
                                              border: Border.all(color: themeData.dividerColor.withOpacity(0.5)),
                                            ),
                                            child: Text(
                                              widget.localSettingConfig.searchEngine?.name ?? '',
                                              style: TextStyle(color: themeData.primaryColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // navigation website urls via provider
                  asyncData.when(
                    data: (data) {
                      if (data == null) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 24),
                            child: CupertinoActivityIndicator(),
                          ),
                        );
                      }
                      return LoadedBody(
                        allUrlsBean: data,
                        isSmallWidthScreen: isSmallWidthScreen,
                        themeData: themeData,
                        fontSize: widget.localSettingConfig.fontSize,
                      );
                    },
                    loading: () => const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: CupertinoActivityIndicator(),
                      ),
                    ),
                    error: (e, st) => const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 12),
                        Icon(CupertinoIcons.exclamationmark_triangle_fill, color: Colors.redAccent, size: 22),
                        SizedBox(height: 6),
                        Text('加载失败，请稍后重试', style: TextStyle(color: Colors.redAccent)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton.extended(
          onPressed: () {
            final searchIcon = widget.localSettingConfig.searchIcon;

            // iOS 风格设置弹窗
            showIOSModal(
              context,
              title: '设置',
              child: StatefulBuilder(
                builder: (context, setLocal) {
                  double fontSize = widget.localSettingConfig.fontSize!;
                  final iconCtrl =
                      TextEditingController(text: searchIcon ?? '');

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 字体大小
                      const Text('文字大小',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          Expanded(
                            child: CupertinoSlider(
                              value: fontSize,
                              min: 10,
                              max: 20,
                              divisions: 10,
                              onChanged: (v) {
                                widget.localSettingConfig.fontSize = v;
                                setState(() {});
                                setLocal(() {});
                                LocalStorage.setItem(
                                  SomeKeys.SETTING_CONFIG,
                                  json.encode(widget.localSettingConfig),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(fontSize.toStringAsFixed(0)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // 设置头像
                      const Text('设置头像',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CupertinoTextField(
                              controller: iconCtrl,
                              placeholder: '请输入头像地址',
                              maxLines: 2,
                              onChanged: (_) => setLocal(() {}),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: SizedBox(
                              width: 48,
                              height: 48,
                              child: Image.network(
                                iconCtrl.text.trim().isEmpty
                                    ? (widget.localSettingConfig.searchIcon ??
                                        LocalSettingConfig.DEF_ICON)
                                    : iconCtrl.text.trim(),
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stack) =>
                                    const Icon(CupertinoIcons.photo),
                              ),
                            ),
                          ),
                          CupertinoButton(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            onPressed: () {
                              final newIcon = iconCtrl.text.trim();
                              if (newIcon.isEmpty) return;
                              Logger.d('searchIcon输入头像地址 $newIcon');
                              setState(() {
                                widget.localSettingConfig.searchIcon = newIcon;
                              });
                              LocalStorage.setItem(
                                SomeKeys.SETTING_CONFIG,
                                json.encode(widget.localSettingConfig),
                              );
                              Navigator.of(context).pop();
                            },
                            child:
                                const Icon(CupertinoIcons.check_mark_circled),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // 修改主题（自动/亮色/暗色）
                      const Text('修改主题',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Builder(builder: (context) {
                        final bool? themePref =
                            widget.localSettingConfig.isDarkTheme;
                        final int selectedIndex = themePref == null
                            ? 0
                            : (themePref == false ? 1 : 2);
                        final theme = ThemeManager.instance.themeData;
                        return CupertinoSegmentedControl<int>(
                          borderColor: theme.dividerColor.withOpacity(0.6),
                          selectedColor: theme.primaryColor,
                          unselectedColor: theme.cardColor,
                          pressedColor: theme.primaryColor.withOpacity(0.15),
                          children: const {
                            0: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(CupertinoIcons.circle_lefthalf_fill,
                                      size: 16),
                                  SizedBox(height: 2),
                                  Text('自动', style: TextStyle(fontSize: 12)),
                                ],
                              ),
                            ),
                            1: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(CupertinoIcons.sun_max_fill, size: 16),
                                  SizedBox(height: 2),
                                  Text('亮色', style: TextStyle(fontSize: 12)),
                                ],
                              ),
                            ),
                            2: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(CupertinoIcons.moon_fill, size: 16),
                                  SizedBox(height: 2),
                                  Text('暗色', style: TextStyle(fontSize: 12)),
                                ],
                              ),
                            ),
                          },
                          groupValue: selectedIndex,
                          onValueChanged: (value) {
                            bool? newPref;
                            if (value == 0) newPref = null; // 跟随系统
                            if (value == 1) newPref = false; // 亮色
                            if (value == 2) newPref = true; // 暗色
                            widget.localSettingConfig.isDarkTheme = newPref;
                            LocalStorage.setItem(
                              SomeKeys.SETTING_CONFIG,
                              json.encode(widget.localSettingConfig),
                            );
                            _toggleTheme();
                            setLocal(() {});
                          },
                        );
                      }),
                    ],
                  );
                },
              ),
            );
          },
          icon: const Icon(CupertinoIcons.gear_alt),
          label: const Text('设置'),
          backgroundColor: themeData.primaryColor,
          foregroundColor: Colors.white,
          shape: const StadiumBorder(),
          elevation: 0,
        ),
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
