import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hao12345/bean/all_urls_bean.dart';
import 'package:url_launcher/url_launcher.dart';

class NavItemTile extends StatelessWidget {
  const NavItemTile({
    super.key,
    required this.item,
    required this.onEdit,
    required this.onDelete,
    this.width,
    this.height = 88,
    this.statusLabel,
    this.statusColor,
    this.statusReason,
  });

  final Results item;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final double? width;
  final double height;
  final String? statusLabel;
  final Color? statusColor;
  final String? statusReason;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final host = () {
      final u = Uri.tryParse(item.url ?? '');
      return u?.host ?? '';
    }();
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: theme.dividerColor),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () async {
                final url = item.url ?? '';
                if (url.isEmpty) return;
                final uri = Uri.tryParse(url);
                if (uri == null) return;
                await launchUrl(
                  uri,
                  webOnlyWindowName: '_blank',
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        item.name ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: theme.textTheme.bodyLarge?.color ??
                              theme.colorScheme.onSurface,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 15),
                      if ((item.description ?? '').isNotEmpty)
                        Expanded(
                          child: Text(
                            item.description!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: theme.textTheme.bodySmall?.color ??
                                    theme.hintColor,
                                fontSize: 13),
                          ),
                        )
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    host,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color:
                            theme.textTheme.bodySmall?.color ?? theme.hintColor,
                        fontSize: 13,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
          ),
          if (statusLabel != null)
            Tooltip(
              message: (statusReason == null || statusReason!.isEmpty)
                  ? statusLabel!
                  : statusReason!,
              child: GestureDetector(
                onTap: () {
                  final reason = statusReason ?? statusLabel!;
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('检测结果'),
                      content: Text(reason),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('知道了'),
                        ),
                      ],
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 6),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: (statusColor ?? theme.hintColor.withOpacity(0.15))
                        .withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: statusColor ?? theme.hintColor),
                  ),
                  child: Text(
                    statusLabel!,
                    style: TextStyle(
                      color: statusColor ?? theme.hintColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: onEdit,
            child: Icon(CupertinoIcons.pencil, color: theme.iconTheme.color),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: onDelete,
            child: Icon(CupertinoIcons.delete, color: theme.colorScheme.error),
          ),
        ],
      ),
    );
  }
}
