import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bean/all_urls_bean.dart';

/// @description: 导航列表页面
/// @author: jixiaoyong
/// @email: jixiaoyong1995@gmail.com
/// @date: 2023/3/20
class LoadedBody extends HookWidget {
  final AllUrlsBean allUrlsBean;
  final bool isSmallWidthScreen;
  final ThemeData themeData;
  final double? fontSize;

  const LoadedBody({
    super.key,
    required this.allUrlsBean,
    required this.isSmallWidthScreen,
    required this.themeData,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final onHoverItem = useState<Results?>(null);
    if (allUrlsBean.results?.isNotEmpty == true) {
      var data = allUrlsBean.results!;
      return Wrap(
        spacing: isSmallWidthScreen ? 15 : 20,
        runSpacing: isSmallWidthScreen ? 10.0 : 20.0,
        alignment: WrapAlignment.center,
        clipBehavior: Clip.hardEdge,
        children: data.map((item) {
          var isSelected = onHoverItem.value == item;

          final chip = Chip(
            label: Text(
              item.name ?? "",
              style: TextStyle(
                  color: themeData.textTheme.bodyLarge?.color ??
                      themeData.colorScheme.onSurface,
                  fontSize: fontSize ?? 15,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500),
            ),
            backgroundColor:
                isSelected ? themeData.hoverColor : themeData.cardColor,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: themeData.cardColor.withOpacity(0.0)),
                borderRadius: BorderRadius.circular(20)),
            elevation: isSelected ? 1 : 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          );

          final withHover = MouseRegion(
            onHover: (event) => onHoverItem.value = item,
            onExit: (_) => onHoverItem.value = null,
            child: chip,
          );

          final wrapped = (item.description?.isNotEmpty == true)
              ? Tooltip(message: item.description!, child: withHover)
              : withHover;

          return GestureDetector(
            onTap: () => launchUrl(Uri.parse(item.url!)),
            child: wrapped,
          );
        }).toList(),
      );
    } else {
      return const Center(
        child: Text("Nothing here,try again later"),
      );
    }
  }
}
