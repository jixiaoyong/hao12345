import 'package:flutter/material.dart';

import '../utils/logger.dart';

/// @description: 设置弹窗
/// @author: jixiaoyong
/// @email: jixiaoyong1995@gmail.com
/// @date: 2023/3/20
class SettingsDialog extends StatefulWidget {
  final String? searchIcon;
  final double fontSize;
  final bool isDarkTheme;
  final ValueChanged<double> updateFontSize;
  final ValueChanged<String> updateSearchIcon;
  final ValueChanged<bool> updateDarkModel;

  const SettingsDialog(
      {Key? key,
      required this.searchIcon,
      required this.fontSize,
      required this.updateFontSize,
      required this.updateSearchIcon,
      required this.updateDarkModel,
      required this.isDarkTheme})
      : super(key: key);

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  @override
  Widget build(BuildContext context) {
    var fontSize = widget.fontSize;
    var searchIcon = widget.searchIcon;
    var isDarkTheme = widget.isDarkTheme;

    return AlertDialog(
      title: const Text('设置'),
      content: StatefulBuilder(
        builder: (context, innerState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("文字大小:$fontSize"),
              Slider(
                value: fontSize,
                onChanged: (value) {
                  widget.updateFontSize(value);
                  fontSize = value;
                  innerState(() {});
                },
                divisions: 10,
                min: 10,
                max: 20,
                label: "$fontSize",
              ),
              const Text("设置头像"),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: "请输入头像地址",
                      ),
                      onChanged: (value) {
                        searchIcon = value;
                        innerState(() {});
                        Logger.d("输入头像地址 $searchIcon");
                      },
                      maxLines: 1,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.check),
                    iconSize: 20,
                    onPressed: () {
                      innerState(() {});
                      if (searchIcon == null || searchIcon?.isEmpty == true) {
                        return;
                      }
                      Logger.d("searchIcon输入头像地址 $searchIcon");

                      widget.updateSearchIcon(searchIcon!);
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
              const Text("修改主题"),
              Row(
                children: [
                  Text(isDarkTheme ? "夜间模式" : "白天模式"),
                  Switch(
                      value: isDarkTheme,
                      onChanged: (bool newValue) {
                        isDarkTheme = newValue;
                        widget.updateDarkModel(newValue);
                        innerState(() {});
                      }),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
