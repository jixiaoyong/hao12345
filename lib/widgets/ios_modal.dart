import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 统一的 iOS 风格弹窗容器
/// 使用 CupertinoModalPopup + CupertinoPopupSurface 提供毛玻璃与圆角外观
Future<T?> showIOSModal<T>(
  BuildContext context, {
  String? title,
  required Widget child,
  double? maxWidth,
  double? maxHeight,
  EdgeInsetsGeometry contentPadding = const EdgeInsets.all(16),
  bool showClose = true,
}) {
  final size = MediaQuery.of(context).size;
  final double resolvedMaxWidth =
      maxWidth ?? (size.width > 640 ? 560 : size.width - 32);
  final double resolvedMaxHeight = maxHeight ?? (size.height - 120);

  return showCupertinoModalPopup<T>(
    context: context,
    builder: (_) => Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          // 点击空白区域关闭
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.of(context).pop(),
              child: const SizedBox.shrink(),
            ),
          ),
          // 弹窗主体
          Center(
            child: CupertinoPopupSurface(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: resolvedMaxWidth,
                  maxHeight: resolvedMaxHeight,
                ),
                child: SafeArea(
                  top: false,
                  child: Padding(
                    padding: contentPadding,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (title != null || showClose)
                          _IOSModalHeader(title: title, showClose: showClose),
                        if (title != null || showClose)
                          const SizedBox(height: 8),
                        Flexible(child: child),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _IOSModalHeader extends StatelessWidget {
  const _IOSModalHeader({this.title, this.showClose = true});
  final String? title;
  final bool showClose;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title ?? '',
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(width: 44),
      ],
    );
  }
}
