import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatusSummaryCard extends StatelessWidget {
  const StatusSummaryCard({
    super.key,
    required this.hasRemote,
    required this.hasDirty,
    required this.remoteFetched,
    required this.localEdited,
    required this.localVersion,
    required this.localUpdatedAt,
    this.remoteVersion,
    this.remoteUpdatedAt,
  });

  final bool hasRemote;
  final bool hasDirty;
  final String remoteFetched;
  final String localEdited;
  final String localVersion;
  final String localUpdatedAt;
  final String? remoteVersion;
  final String? remoteUpdatedAt;

  @override
  Widget build(BuildContext context) {
    final labelStyle = const TextStyle(color: CupertinoColors.secondaryLabel);
    final valueStyle = const TextStyle(color: CupertinoColors.label);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: CupertinoColors.systemGroupedBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: CupertinoColors.separator.withOpacity(0.2)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _SectionHeader(title: '同步状态'),
              _ItemRow(
                label: '数据源',
                child: Text(
                  hasRemote ? '在线（优先远程）' : '离线（本地）',
                  style: valueStyle,
                ),
                labelStyle: labelStyle,
              ),
              _Separator(),
              _ItemRow(
                label: '未同步',
                child: Text(hasDirty ? '是' : '否', style: valueStyle),
                labelStyle: labelStyle,
              ),
              _Separator(),
              _ItemRow(
                label: '上次拉取远程',
                child: Text(remoteFetched, style: valueStyle),
                labelStyle: labelStyle,
                expands: true,
              ),
              _Separator(),
              _ItemRow(
                label: '上次本地编辑',
                child: Text(localEdited, style: valueStyle),
                labelStyle: labelStyle,
                expands: true,
              ),
              _Separator(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.secondarySystemGroupedBackground,
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 8),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
      ),
    );
  }
}

class _ItemRow extends StatelessWidget {
  const _ItemRow({
    required this.label,
    required this.child,
    required this.labelStyle,
    this.expands = false,
  });

  final String label;
  final TextStyle labelStyle;
  final Widget child;
  final bool expands;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.systemBackground,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(label, style: labelStyle),
          const SizedBox(width: 8),
          if (expands) Expanded(child: child) else child,
        ],
      ),
    );
  }
}

class _Separator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.5,
      color: CupertinoColors.separator,
    );
  }
}
