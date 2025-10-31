import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hao12345/utils/screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hao12345/bean/local_setting_config.dart';

import '../state/navigation_view_model.dart';
import '../state/home_setting_view_model.dart';
import '../theme/theme_manager.dart';
import '../widgets/search_input_box.dart';
import 'loaded_body.dart';
import 'home_setting_dialog.dart';

/// author: jixiaoyong
/// email: jixiaoyong1995@gmail.com
/// date: 2022/3/28
/// description: hao123主页
class Hao123Page extends ConsumerStatefulWidget {
  const Hao123Page({super.key});

  @override
  ConsumerState<Hao123Page> createState() => _Hao123PageState();
}

class _Hao123PageState extends ConsumerState<Hao123Page> {
  String? loadError;

  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var isSmallWidthScreen = context.isMobile;
    var inputMethodPadding = screenWidth / 20;
    if (isSmallWidthScreen) {
      inputMethodPadding = 5;
    }

    var iconSize = screenWidth / 8;
    if (iconSize < 80) {
      iconSize = 80;
    }

    final themeData = ref.watch(themeManagerProvider);

    return Scaffold(
      backgroundColor: themeData.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: themeData.scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          CupertinoButton(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: const Icon(CupertinoIcons.list_bullet),
            onPressed: () => Navigator.of(context).pushNamed('/manage'),
          ),
        ],
      ),
      body: Center(
        child: Consumer(builder: (context, ref, _) {
          final asyncData = ref.watch(navigationViewModelProvider);
          final settings = ref.watch(homeSettingViewModelProvider);

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(inputMethodPadding,
                  inputMethodPadding, inputMethodPadding, kIsWeb ? 150 : 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(iconSize),
                    child: Image.network(
                      settings.searchIcon ?? LocalSettingConfig.DEF_ICON,
                      height: iconSize,
                      width: iconSize,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // search box
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: inputMethodPadding,
                      vertical: 20,
                    ),
                    child: SearchInputBox(
                      controller: _textController,
                      isSmallScreen: isSmallWidthScreen,
                    ),
                  ),
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
                        fontSize: settings.fontSize ?? 15.0,
                      );
                    },
                    loading: () => const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: CupertinoActivityIndicator(),
                      ),
                    ),
                    error: (e, st) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 12),
                        Icon(CupertinoIcons.exclamationmark_triangle_fill,
                            color: themeData.colorScheme.error, size: 22),
                        const SizedBox(height: 6),
                        Text('加载失败，请稍后重试',
                            style:
                                TextStyle(color: themeData.colorScheme.error)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
      floatingActionButton: CupertinoButton.filled(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: const Icon(CupertinoIcons.gear_alt),
        onPressed: () {
          showHomeSettingDialog(context);
        },
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
