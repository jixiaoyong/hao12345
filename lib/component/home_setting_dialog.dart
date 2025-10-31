import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hao12345/state/home_setting_view_model.dart';
import 'package:hao12345/theme/theme_manager.dart';
import 'package:hao12345/bean/local_setting_config.dart';
import 'package:hao12345/widgets/ios_modal.dart';
import 'package:hao12345/utils/logger.dart';

class HomeSettingDialog extends ConsumerStatefulWidget {
  const HomeSettingDialog({super.key});

  @override
  ConsumerState<HomeSettingDialog> createState() => _HomeSettingDialogState();
}

class _HomeSettingDialogState extends ConsumerState<HomeSettingDialog> {
  late TextEditingController _iconController;
  double _tempFontSize = 15.0;
  String? _tempSearchIcon;
  Timer? _iconUpdateTimer;

  @override
  void initState() {
    super.initState();
    _iconController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final config = ref.read(homeSettingViewModelProvider);
      _tempFontSize = config.fontSize ?? 15.0;
      _tempSearchIcon = config.searchIcon;
      _iconController.text = _tempSearchIcon ?? '';
    });
  }

  @override
  void dispose() {
    _iconUpdateTimer?.cancel();
    _iconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(homeSettingViewModelProvider);
    final theme = ref.watch(themeManagerProvider);

    if (_tempFontSize != (config.fontSize ?? 15.0)) {
      _tempFontSize = config.fontSize ?? 15.0;
    }
    if (_tempSearchIcon != config.searchIcon) {
      _tempSearchIcon = config.searchIcon;
      _iconController.text = _tempSearchIcon ?? '';
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '文字大小',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Expanded(
              child: CupertinoSlider(
                value: config.fontSize ?? 15.0,
                min: 10,
                max: 20,
                divisions: 10,
                onChanged: (value) {
                  ref
                      .read(homeSettingViewModelProvider.notifier)
                      .updateFontSize(value);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text((config.fontSize ?? 15.0).toStringAsFixed(0)),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // 设置头像
        const Text(
          '设置头像',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CupertinoTextField(
                controller: _iconController,
                placeholder: '请输入头像地址',
                maxLines: 2,
                onChanged: (value) {
                  setState(() {});
                  _iconUpdateTimer?.cancel();
                  final trimmedValue = value.trim();
                  if (trimmedValue.isNotEmpty) {
                    _iconUpdateTimer =
                        Timer(const Duration(milliseconds: 800), () {
                      final currentValue = _iconController.text.trim();
                      if (currentValue == trimmedValue &&
                          trimmedValue.isNotEmpty &&
                          mounted) {
                        Logger.d('searchIcon输入头像地址 $trimmedValue');
                        ref
                            .read(homeSettingViewModelProvider.notifier)
                            .updateSearchIcon(trimmedValue);
                      }
                    });
                  }
                },
              ),
            ),
            const SizedBox(width: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 48,
                height: 48,
                child: Image.network(
                  _iconController.text.trim().isEmpty
                      ? (config.searchIcon ?? LocalSettingConfig.DEF_ICON)
                      : _iconController.text.trim(),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stack) =>
                      const Icon(CupertinoIcons.photo),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // 修改主题（自动/亮色/暗色）
        const Text(
          '修改主题',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Builder(builder: (context) {
          final bool? themePref = config.isDarkTheme;
          final int selectedIndex =
              themePref == null ? 0 : (themePref == false ? 1 : 2);
          return CupertinoSegmentedControl<int>(
            borderColor: theme.dividerColor.withOpacity(0.6),
            selectedColor: theme.primaryColor,
            unselectedColor: theme.cardColor,
            pressedColor: theme.primaryColor.withOpacity(0.15),
            children: const {
              0: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(CupertinoIcons.circle_lefthalf_fill, size: 16),
                    SizedBox(height: 2),
                    Text('自动', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
              1: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
              Logger.d('updateThemePreference $newPref  value: $value');
              ref
                  .read(homeSettingViewModelProvider.notifier)
                  .updateThemePreference(newPref);
            },
          );
        }),
      ],
    );
  }
}

/// Helper function to show the home setting dialog
Future<void> showHomeSettingDialog(BuildContext context) {
  return showIOSModal(
    context,
    title: '设置',
    child: const HomeSettingDialog(),
  );
}
