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
  final Color backgroundColor;
  final ValueChanged<double> updateFontSize;
  final ValueChanged<String> updateSearchIcon;
  final ValueChanged<bool> updateDarkModel;

  const SettingsDialog(
      {Key? key,
      required this.backgroundColor,
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

    var textStyle = TextStyle(
      color: Colors.grey[100],
    );

    return AlertDialog(
      title: Text(
        '设置',
        style: textStyle,
      ),
      backgroundColor: Colors.black.withOpacity(0.6),
      contentTextStyle: textStyle,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: StatefulBuilder(
        builder: (context, innerState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SettingsItem(
                title: "文字大小:$fontSize",
                child: Slider(
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
              ),
              SettingsItem(
                title: "设置头像",
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "请输入头像地址",
                          hintStyle: textStyle,
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
              ),
              SettingsItem(
                title: "修改主题",
                child: Row(
                  children: [
                    Text(
                      isDarkTheme ? "夜间模式" : "白天模式",
                    ),
                    Switch(
                        value: isDarkTheme,
                        onChanged: (bool newValue) {
                          isDarkTheme = newValue;
                          widget.updateDarkModel(newValue);
                          innerState(() {});
                        }),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  final String title;
  final Widget child;

  const SettingsItem({Key? key, required this.title, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey.withOpacity(0.8)),
            ),
            child: child,
          ),
        )
      ],
    );
  }
}
