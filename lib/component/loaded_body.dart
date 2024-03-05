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
    Key? key,
    required this.allUrlsBean,
    required this.isSmallWidthScreen,
    required this.themeData,
    required this.fontSize,
  }) : super(key: key);

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
          return GestureDetector(
            onTap: () {
              launch(
                item.url!,
              );
            },
            child: MouseRegion(
              onHover: (event) {
                setState(() {
                  _onHoverItem = item;
                });
              },
              child: Chip(
                  label: Text(
                    item.name ?? "",
                    style: TextStyle(
                        color: isSelected
                            ? widget.themeData.highlightColor
                            : widget.themeData.hintColor,
                        fontSize: widget.fontSize ?? 15),
                  ),
                  backgroundColor: isSelected
                      ? widget.themeData.hoverColor
                      : Colors.grey[100],
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(20))),
            ),
          );
        }).toList(),
      );
    } else {
      return const Center(
        child: Text("Nothing here,try again later"),
      );
    }
    ;
  }
}
