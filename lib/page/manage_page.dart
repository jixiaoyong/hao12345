import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hao12345/bean/all_urls_bean.dart';
import 'dart:html' as html;
import 'package:hao12345/widgets/nav_item_tile.dart';
import 'package:hao12345/state/manage_page_view_model.dart';
import 'package:hao12345/widgets/ios_modal.dart';

class ManagePage extends HookConsumerWidget {
  const ManagePage({super.key});

  void _showOk(BuildContext context, String message) {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('好'),
          ),
        ],
      ),
    );
  }

  void _openEditDialog(
    BuildContext context,
    WidgetRef ref, {
    int? index,
    Results? initial,
  }) {
    final item = index == null
        ? (initial ?? Results(name: '', url: ''))
        : Results(
            name: initial?.name,
            url: initial?.url,
            description: initial?.description,
            createdAt: initial?.createdAt,
            updatedAt: initial?.updatedAt,
            objectId: initial?.objectId,
          );
    final nameCtrl = TextEditingController(text: item.name ?? '');
    final urlCtrl = TextEditingController(text: item.url ?? '');
    final remarkCtrl = TextEditingController(text: item.description ?? '');
    showIOSModal(
      context,
      title: index == null ? '新增导航' : '编辑导航',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          CupertinoTextField(
            controller: nameCtrl,
            placeholder: '名称',
          ),
          const SizedBox(height: 8),
          CupertinoTextField(
            controller: urlCtrl,
            placeholder: 'https://example.com',
            keyboardType: TextInputType.url,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(height: 8),
          CupertinoTextField(
            controller: remarkCtrl,
            placeholder: '备注（可选）',
            maxLines: null,
            expands: true,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CupertinoButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('取消'),
              ),
              const SizedBox(width: 8),
              CupertinoButton.filled(
                onPressed: () {
                  final name = nameCtrl.text.trim();
                  final url = urlCtrl.text.trim();
                  if (name.isEmpty || url.isEmpty) return;
                  final parsed = Uri.tryParse(url);
                  if (parsed == null || !parsed.hasScheme) return;
                  final updated = Results(
                    name: name,
                    url: url,
                    description: remarkCtrl.text.trim().isEmpty
                        ? null
                        : remarkCtrl.text.trim(),
                    createdAt: item.createdAt,
                    updatedAt: item.updatedAt,
                    objectId: item.objectId,
                  );
                  ref
                      .read(manageViewModelProvider.notifier)
                      .upsertItem(index: index, item: updated);
                  Navigator.pop(context);
                },
                child: const Text('确定'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(manageViewModelProvider);
    final notifier = ref.read(manageViewModelProvider.notifier);
    final isReorderMode = useState(false);

    final theme = Theme.of(context);
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: const Text('管理'),
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: DefaultTextStyle.merge(
          style: TextStyle(
            color: theme.textTheme.bodyMedium?.color ??
                theme.colorScheme.onSurface,
            decoration: TextDecoration.none,
          ),
          child: isReorderMode.value
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (vm.errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                        child: Text(
                          vm.errorMessage!,
                          style: TextStyle(color: theme.colorScheme.error),
                        ),
                      ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                      child: Text('长按右侧的二横线拖拽条目以重新排序（当前仅支持“全部”视图）'),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ReorderableListView.builder(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
                        itemCount: vm.draft?.results?.length ?? 0,
                        onReorder: (oldIndex, newIndex) {
                          if (newIndex > oldIndex) newIndex -= 1;
                          notifier.reorderAt(oldIndex, newIndex);
                        },
                        itemBuilder: (context, index) {
                          final it =
                              (vm.draft?.results ?? const <Results>[])[index];
                          final k = ValueKey(notifier.keyOf(it));
                          return ListTile(
                            key: k,
                            title: Text(it.name ?? ''),
                            subtitle: Text(
                              it.url ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              : ListView(
                  children: [
                    if (vm.errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                        child: Text(
                          vm.errorMessage!,
                          style: TextStyle(color: theme.colorScheme.error),
                        ),
                      ),
                    const SizedBox(height: 8),
                    if (notifier.hasAnyReachability)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            _FilterChip(
                              label: '全部',
                              selected: vm.filter == ReachabilityFilter.all,
                              onTap: () =>
                                  notifier.setFilter(ReachabilityFilter.all),
                            ),
                            const SizedBox(width: 8),
                            _FilterChip(
                              label: '可达',
                              color: const Color(0xFF2E7D32),
                              selected:
                                  vm.filter == ReachabilityFilter.reachable,
                              onTap: () => notifier
                                  .setFilter(ReachabilityFilter.reachable),
                            ),
                            const SizedBox(width: 8),
                            _FilterChip(
                              label: '不可达',
                              color: const Color(0xFFC62828),
                              selected:
                                  vm.filter == ReachabilityFilter.unreachable,
                              onTap: () => notifier
                                  .setFilter(ReachabilityFilter.unreachable),
                            ),
                            const SizedBox(width: 8),
                            _FilterChip(
                              label: '检测中',
                              color: const Color(0xFF1976D2),
                              selected:
                                  vm.filter == ReachabilityFilter.checking,
                              onTap: () => notifier
                                  .setFilter(ReachabilityFilter.checking),
                            ),
                          ],
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                      child: Builder(builder: (context) {
                        final total = vm.draft?.results?.length ?? 0;
                        final visible = notifier.getFilteredResults().length;
                        return Text('共 $total 个，当前显示 $visible 个');
                      }),
                    ),
                    const SizedBox(height: 4),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final cols = constraints.maxWidth >= 700 ? 2 : 1;
                        const gap = 12.0;
                        final items = notifier.getFilteredResults();
                        const horizontalPadding = 16.0;
                        final itemWidth = (constraints.maxWidth -
                                horizontalPadding * 2 -
                                gap * (cols - 1)) /
                            cols;
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: horizontalPadding),
                          child: Wrap(
                            spacing: gap,
                            runSpacing: 10,
                            children: List.generate(items.length, (i) {
                              final it = items[i] as Results? ??
                                  Results(name: '', url: '');
                              final key = notifier.keyOf(it);
                              final originalIndex = notifier.indexOf(it);
                              return NavItemTile(
                                width: itemWidth,
                                item: it,
                                statusLabel: notifier.statusLabelOf(it).isEmpty
                                    ? null
                                    : notifier.statusLabelOf(it),
                                statusColor: notifier.statusColorOf(it),
                                statusReason: notifier.reasonOf(it),
                                onEdit: () => _openEditDialog(context, ref,
                                    index: originalIndex >= 0
                                        ? originalIndex
                                        : null,
                                    initial: it),
                                onDelete: () => notifier.deleteByKey(key),
                              );
                            }),
                          ),
                        );
                      },
                    ),
                  ],
                ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          decoration:
              BoxDecoration(color: theme.scaffoldBackgroundColor, boxShadow: [
            BoxShadow(
              color: theme.dividerColor.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, -2),
            )
          ]),
          child: Wrap(spacing: 8, runSpacing: 8, children: [
            if (isReorderMode.value) ...[
              CupertinoButton(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                color: theme.colorScheme.primary,
                onPressed: () => isReorderMode.value = false,
                child: const Text('保存并退出排序'),
              ),
              CupertinoButton(
                onPressed: () {
                  isReorderMode.value = false;
                },
                child: const Text('取消排序'),
              ),
            ] else ...[
              CupertinoButton.filled(
                onPressed: () => _openEditDialog(context, ref),
                child: const Text('新增'),
              ),
              CupertinoButton.filled(
                onPressed: () {
                  notifier.setFilter(ReachabilityFilter.all);
                  isReorderMode.value = true;
                },
                child: const Text('排序'),
              ),
              CupertinoButton.filled(
                onPressed: () async {
                  await notifier.saveToLocal();
                  _showOk(context,
                      '已保存到本地。若需永久保存，请更新在线的 assets/data/default_nav.json');
                },
                child: const Text('保存到本地'),
              ),
              CupertinoButton(
                onPressed: (vm.isCheckingReachability == true)
                    ? null
                    : () async {
                        await notifier.checkAllReachability();
                      },
                child: Text(
                  (vm.isCheckingReachability == true)
                      ? '检测中…'
                      : (notifier.hasAnyReachability ? '重新检测' : '检测可达性'),
                ),
              ),
              CupertinoButton(
                onPressed: () {
                  final text = ref
                      .read(manageViewModelProvider.notifier)
                      .buildExportJson();
                  html.window.navigator.clipboard?.writeText(text);
                  _showOk(context, 'JSON 已复制到剪贴板');
                },
                child: const Text('复制 JSON'),
              ),
              CupertinoButton(
                onPressed: () {
                  final text = ref
                      .read(manageViewModelProvider.notifier)
                      .buildExportJson();
                  final bytes = utf8.encode(text);
                  final blob = html.Blob([bytes], 'application/json');
                  final url = html.Url.createObjectUrlFromBlob(blob);
                  final anchor = html.AnchorElement(href: url)
                    ..download = 'nav.json';
                  anchor.click();
                  html.Url.revokeObjectUrl(url);
                },
                child: const Text('下载 JSON'),
              ),
            ],
          ]),
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.color,
  });
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = selected
        ? (color ?? theme.colorScheme.primary)
        : (color ?? theme.dividerColor).withOpacity(0.6);
    final textColor =
        selected ? (color ?? theme.colorScheme.primary) : borderColor;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? (borderColor.withOpacity(0.12)) : theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
