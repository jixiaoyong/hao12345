import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hao12345/bean/local_setting_config.dart';
import 'package:hao12345/state/home_setting_view_model.dart';
import 'package:hao12345/theme/theme_manager.dart';
import 'package:hao12345/widgets/ios_modal.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeSettingDialog extends HookConsumerWidget {
  const HomeSettingDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(homeSettingViewModelProvider);
    final theme = ref.watch(themeManagerProvider);
    final homeSettingNotifier = ref.read(homeSettingViewModelProvider.notifier);

    final iconController = useTextEditingController();

    useEffect(() {
      final modelIcon = config.searchIcon ?? '';
      if (iconController.text != modelIcon) {
        iconController.text = modelIcon;
      }
      return null;
    }, [config.searchIcon]);

    final iconText = useValueListenable(iconController).text;
    useEffect(() {
      final trimmedValue = iconText.trim();
      // Avoid sending an update if the value is already what's in the provider
      if (trimmedValue == (config.searchIcon ?? '')) {
        return null;
      }

      final timer = Timer(const Duration(milliseconds: 1500), () {
        homeSettingNotifier.updateSearchIcon(trimmedValue);
      });

      return () => timer.cancel();
    }, [iconText]);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('文字大小', style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: [
            Expanded(
              child: CupertinoSlider(
                value: config.fontSize ?? 15.0,
                min: 10,
                max: 20,
                divisions: 10,
                onChanged: (value) {
                  homeSettingNotifier.updateFontSize(value);
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
        const Text('设置头像', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CupertinoTextField(
                  controller: iconController,
                  placeholder: '请输入头像地址',
                  maxLines: 2),
            ),
            const SizedBox(width: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 48,
                height: 48,
                child: Image.network(
                  iconText.trim().isEmpty
                      ? (config.searchIcon ?? LocalSettingConfig.DEF_ICON)
                      : iconText.trim(),
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
        const Text('修改主题', style: TextStyle(fontWeight: FontWeight.bold)),
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
            children: {
              0: _themeItem(CupertinoIcons.circle_lefthalf_fill, '自动'),
              1: _themeItem(CupertinoIcons.sun_max_fill, '亮色'),
              2: _themeItem(CupertinoIcons.moon_fill, '暗色'),
            },
            groupValue: selectedIndex,
            onValueChanged: (value) {
              bool? newPref;
              if (value == 0) newPref = null; // 跟随系统
              if (value == 1) newPref = false; // 亮色
              if (value == 2) newPref = true; // 暗色
              ref
                  .read(homeSettingViewModelProvider.notifier)
                  .updateThemePreference(newPref);
            },
          );
        }),
      ],
    );
  }

  Widget _themeItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16),
          const SizedBox(height: 2),
          Text(text, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

Future<void> showHomeSettingDialog(BuildContext context) {
  return showIOSModal(
    context,
    title: '设置',
    child: const HomeSettingDialog(),
  );
}
