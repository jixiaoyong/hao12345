import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bean/all_urls_bean.dart';

/// @description: TODO
/// @author: jixiaoyong
/// @email: jixiaoyong1995@gmail.com
/// @date: 2023/3/20
class LoadedBody extends StatefulWidget {
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
  State<LoadedBody> createState() => _LoadedBodyState();
}

class _LoadedBodyState extends State<LoadedBody> {
  // for webview
  Results? _onHoverItem;

  @override
  Widget build(BuildContext context) {
    if (widget.allUrlsBean.results?.isNotEmpty == true) {
      var data = widget.allUrlsBean.results!;
      return Wrap(
        spacing: widget.isSmallWidthScreen ? 5 : 20,
        runSpacing: widget.isSmallWidthScreen ? 2.0 : 20.0,
        alignment: WrapAlignment.center,
        clipBehavior: Clip.hardEdge,
        children: data.map((item) {
          var isSelected = _onHoverItem == item;
          final isDark = widget.themeData.brightness == Brightness.dark;
          final Color textColor = isDark
              ? Colors.black.withOpacity(0.85)
              : widget.themeData.hintColor;
          final Color hoverTextColor = isDark
              ? Colors.black
              : widget.themeData.highlightColor;
          final Color bgColor = isDark
              ? Colors.black.withOpacity(0.5)
              : (Colors.grey[100]!); // 亮色模式保持之前浅灰
          final Color hoverBgColor = isDark
              ? Colors.white.withOpacity(0.12)
              : widget.themeData.hoverColor;

          final chip = Chip(
              label: Text(
                item.name ?? "",
                style: TextStyle(
                    color: isSelected ? hoverTextColor : textColor,
                    fontSize: widget.fontSize ?? 15,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500),
              ),
              backgroundColor: isSelected ? hoverBgColor : bgColor,
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: widget.themeData.dividerColor.withOpacity(0.0)),
                  borderRadius: BorderRadius.circular(20)),
              elevation: isSelected ? 1 : 0,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          );

          final withHover = MouseRegion(
            onHover: (event) {
              setState(() {
                _onHoverItem = item;
              });
            },
            onExit: (_) {
              setState(() {
                _onHoverItem = null;
              });
            },
            child: chip,
          );

          final wrapped = (item.description?.isNotEmpty == true)
              ? Tooltip(message: item.description!, child: withHover)
              : withHover;

          return GestureDetector(
            onTap: () {
              launch(
                item.url!,
              );
            },
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
