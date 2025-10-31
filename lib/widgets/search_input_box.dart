import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hao12345/bean/search_engine.dart';
import 'package:hao12345/state/home_setting_view_model.dart';
import 'package:hao12345/theme/theme_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchInputBox extends ConsumerWidget {
  final TextEditingController controller;
  final bool isSmallScreen;

  const SearchInputBox({
    super.key,
    required this.controller,
    this.isSmallScreen = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeManagerProvider);
    final settings = ref.watch(homeSettingViewModelProvider);

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 5 : 8.0,
        vertical: 8.0,
      ),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: theme.dividerColor.withOpacity(0.5),
          width: 0.5,
        ),
      ),
      height: 44,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Icon(
              CupertinoIcons.search,
              size: 18,
              color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6) ??
                  theme.hintColor,
            ),
          ),
          // Input field
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: controller,
                style: TextStyle(
                  fontSize: 17,
                  color: theme.textTheme.bodyLarge?.color ??
                      theme.colorScheme.onSurface,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '搜索',
                  hintStyle: TextStyle(
                    color: theme.textTheme.bodySmall?.color ?? theme.hintColor,
                    fontSize: 17,
                  ),
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                ),
                onSubmitted: (String value) {
                  if (value.isEmpty) {
                    return;
                  }
                  final searchEngine =
                      settings.searchEngine ?? SearchEngine.Google;
                  launchUrl(Uri.parse("${searchEngine.url}${value}"));
                },
              ),
            ),
          ),
          _SearchEngineSelector(theme: theme),
        ],
      ),
    );
  }
}

class _SearchEngineSelector extends ConsumerWidget {
  final ThemeData theme;

  const _SearchEngineSelector({required this.theme});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(homeSettingViewModelProvider);

    return Builder(builder: (btnCtx) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              minSize: 0,
              onPressed: () async {
                final overlay =
                    Overlay.of(btnCtx).context.findRenderObject() as RenderBox?;
                final btnBox = btnCtx.findRenderObject() as RenderBox?;
                if (btnBox == null || overlay == null) return;
                final offset = btnBox.localToGlobal(
                  Offset.zero,
                  ancestor: overlay,
                );
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
                    final currentEngine =
                        settings.searchEngine ?? SearchEngine.Google;
                    final isSel = currentEngine == e;
                    return PopupMenuItem<SearchEngine>(
                      value: e,
                      child: Row(children: [
                        if (isSel)
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Icon(
                              Icons.check,
                              size: 18,
                              color: theme.primaryColor,
                            ),
                          ),
                        Text(
                          e.name,
                          style: TextStyle(
                            color: theme.textTheme.bodyMedium?.color ??
                                theme.colorScheme.onSurface,
                          ),
                        ),
                      ]),
                    );
                  }).toList(),
                );
                if (selected != null) {
                  ref
                      .read(homeSettingViewModelProvider.notifier)
                      .updateSearchEngine(selected);
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    CupertinoIcons.arrow_swap,
                    size: 16,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '切换',
                    style: TextStyle(
                      fontSize: 15,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: theme.dividerColor.withOpacity(0.5),
                ),
              ),
              child: Text(
                (settings.searchEngine ?? SearchEngine.Google).name,
                style: TextStyle(
                  fontSize: 13,
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
