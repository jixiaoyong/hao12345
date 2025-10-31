import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hao12345/bean/all_urls_bean.dart';
import 'package:hao12345/repository/navigation_repository.dart';
import 'package:hao12345/state/navigation_view_model.dart';
import 'package:hao12345/utils/local_storage.dart';
import 'package:hao12345/utils/some_keys.dart';
import 'package:flutter/material.dart';
import 'package:hao12345/utils/reachability.dart' as reach;

class ManageState {
  final AsyncValue<AllUrlsBean?> data;
  final AllUrlsBean? draft;
  final String? errorMessage;
  final Map<String, ReachabilityStatus> reachability;
  final ReachabilityFilter filter;
  final Map<String, String> reachabilityReason;
  final bool? isCheckingReachability;

  const ManageState({
    required this.data,
    required this.draft,
    required this.errorMessage,
    required this.reachability,
    required this.filter,
    required this.reachabilityReason,
    required this.isCheckingReachability,
  });

  ManageState copyWith({
    AsyncValue<AllUrlsBean?>? data,
    AllUrlsBean? draft,
    String? errorMessage,
    Map<String, ReachabilityStatus>? reachability,
    ReachabilityFilter? filter,
    Map<String, String>? reachabilityReason,
    bool? isCheckingReachability,
  }) {
    return ManageState(
      data: data ?? this.data,
      draft: draft ?? this.draft,
      errorMessage: errorMessage,
      reachability: reachability ?? this.reachability,
      filter: filter ?? this.filter,
      reachabilityReason: reachabilityReason ?? this.reachabilityReason,
      isCheckingReachability:
          isCheckingReachability ?? this.isCheckingReachability,
    );
  }

  factory ManageState.initial() => const ManageState(
        data: AsyncLoading(),
        draft: null,
        errorMessage: null,
        reachability: {},
        filter: ReachabilityFilter.all,
        reachabilityReason: {},
        isCheckingReachability: false,
      );
}

enum ReachabilityStatus { unknown, checking, reachable, unreachable }

enum ReachabilityFilter { all, reachable, unreachable, checking }

final manageViewModelProvider =
    NotifierProvider<ManageViewModel, ManageState>(ManageViewModel.new);

class ManageViewModel extends Notifier<ManageState> {
  late final NavigationRepository _repo;

  @override
  ManageState build() {
    _repo = ref.read(navigationRepositoryProvider);
    Future.microtask(() => _load());
    return ManageState.initial();
  }

  Future<void> _load() async {
    state = state.copyWith(data: const AsyncLoading(), errorMessage: null);
    final result = await AsyncValue.guard(() async => await _repo.fetch());
    state = state.copyWith(
      data: result,
      draft: result.value == null
          ? null
          : AllUrlsBean(
              version: result.value?.version,
              updatedAt: result.value?.updatedAt,
              results: List.of(result.value?.results ?? []),
            ),
      errorMessage: result.hasError ? '加载失败，请检查网络后重试' : null,
    );
  }

  bool get hasAnyReachability =>
      state.reachability.values.any((e) => e != ReachabilityStatus.unknown);

  void setFilter(ReachabilityFilter filter) {
    state = state.copyWith(filter: filter);
  }

  List<Results> getFilteredResults() {
    final items = state.draft?.results ?? <Results>[];
    switch (state.filter) {
      case ReachabilityFilter.all:
        return items;
      case ReachabilityFilter.reachable:
        return items
            .where((e) => _statusOf(e) == ReachabilityStatus.reachable)
            .toList();
      case ReachabilityFilter.unreachable:
        return items
            .where((e) => _statusOf(e) == ReachabilityStatus.unreachable)
            .toList();
      case ReachabilityFilter.checking:
        return items
            .where((e) => _statusOf(e) == ReachabilityStatus.checking)
            .toList();
    }
  }

  ReachabilityStatus _statusOf(Results e) {
    final key = e.objectId ?? e.url ?? '';
    return state.reachability[key] ?? ReachabilityStatus.unknown;
  }

  String keyOf(Results e) => e.objectId ?? e.url ?? '';

  int indexOf(Results e) {
    final key = keyOf(e);
    final list = state.draft?.results ?? <Results>[];
    return list.indexWhere((it) => keyOf(it) == key);
  }

  void deleteByKey(String key) {
    final list = List<Results>.of(state.draft?.results ?? <Results>[]);
    final idx = list.indexWhere((e) => keyOf(e) == key);
    if (idx < 0) return;
    list.removeAt(idx);
    state = state.copyWith(
      draft: AllUrlsBean(
        results: list,
        version: state.draft?.version,
        updatedAt: state.draft?.updatedAt,
      ),
      errorMessage: null,
    );
  }

  String statusLabelOf(Results e) {
    switch (_statusOf(e)) {
      case ReachabilityStatus.unknown:
        return '';
      case ReachabilityStatus.checking:
        return '检测中';
      case ReachabilityStatus.reachable:
        return '可达';
      case ReachabilityStatus.unreachable:
        return '不可达';
    }
  }

  Color statusColorOf(Results e) {
    switch (_statusOf(e)) {
      case ReachabilityStatus.unknown:
        return const Color(0xFFBDBDBD);
      case ReachabilityStatus.checking:
        return const Color(0xFF1976D2);
      case ReachabilityStatus.reachable:
        return const Color(0xFF2E7D32);
      case ReachabilityStatus.unreachable:
        return const Color(0xFFC62828);
    }
  }

  String? reasonOf(Results e) {
    final key = e.objectId ?? e.url ?? '';
    return state.reachabilityReason[key];
  }

  Future<void> checkAllReachability() async {
    final items = List<Results>.of(state.draft?.results ?? <Results>[]);
    if (items.isEmpty) return;
    state = state.copyWith(isCheckingReachability: true);
    final statusMap = <String, ReachabilityStatus>{};
    final reasonMap = <String, String>{};
    final urlList = <String>[];
    String keyFor(Results e) => e.objectId ?? e.url ?? '';
    final urlToKey = <String, String>{};
    for (final e in items) {
      final key = keyFor(e);
      statusMap[key] = ReachabilityStatus.checking;
      final url = (e.url ?? '').trim();
      if (url.isNotEmpty) {
        urlList.add(url);
        urlToKey[url] = key;
      }
    }
    state =
        state.copyWith(reachability: statusMap, reachabilityReason: reasonMap);

    if (urlList.isEmpty) return;

    // 使用流式批量检测，边到边更
    try {
      final stream = reach.streamCheckReachability(urlList);
      await for (final evt in stream) {
        final url = (evt['url'] as String?)?.trim();
        final reachable = evt['reachable'] as bool?;
        final reason = evt['reason'] as String?;
        if (url == null || reachable == null) continue;
        final key = urlToKey[url];
        if (key == null) continue;
        statusMap[key] = reachable
            ? ReachabilityStatus.reachable
            : ReachabilityStatus.unreachable;
        if (reason != null && reason.isNotEmpty) {
          reasonMap[key] = reason;
        }
        state = state.copyWith(
          reachability: Map<String, ReachabilityStatus>.from(statusMap),
          reachabilityReason: Map<String, String>.from(reasonMap),
        );
      }
    } finally {
      state = state.copyWith(isCheckingReachability: false);
    }
  }

  int? get localDataVersion {
    final cache = LocalStorage.getItem(SomeKeys.NAV_CACHE);
    if (cache != null && cache.isNotEmpty) {
      try {
        final j = jsonDecode(cache);
        return (j['version'] as num?)?.toInt();
      } catch (_) {}
    }
    return state.draft?.version ?? state.data.value?.version;
  }

  String get localDataUpdatedAt {
    final cache = LocalStorage.getItem(SomeKeys.NAV_CACHE);
    if (cache != null && cache.isNotEmpty) {
      try {
        final j = jsonDecode(cache);
        final v = j['updatedAt'];
        if (v is String && v.isNotEmpty) return v;
      } catch (_) {}
    }
    return state.draft?.updatedAt ?? state.data.value?.updatedAt ?? '-';
  }

  void deleteAt(int index) {
    final list = List<Results>.of(state.draft?.results ?? <Results>[]);
    if (index < 0 || index >= list.length) return;
    list.removeAt(index);
    state = state.copyWith(
      draft: AllUrlsBean(results: list),
      errorMessage: null,
    );
  }

  void upsertItem({int? index, required Results item}) {
    final list = List<Results>.of(state.draft?.results ?? <Results>[]);
    final existsIndex = list.indexWhere((e) =>
        (e.name ?? '') == (item.name ?? '') ||
        (e.url ?? '') == (item.url ?? ''));
    if (existsIndex != -1 && existsIndex != (index ?? -1)) {
      state = state.copyWith(errorMessage: '名称或 URL 重复，请检查');
      return;
    }
    final nowIso = DateTime.now().toUtc().toIso8601String();
    final updated = Results(
      name: item.name,
      url: item.url,
      description: item.description,
      createdAt: item.createdAt ?? nowIso,
      updatedAt: nowIso,
      objectId: item.objectId ?? 'obj-${DateTime.now().millisecondsSinceEpoch}',
    );
    if (index == null) {
      list.add(updated);
    } else {
      list[index] = updated;
    }
    state = state.copyWith(
      draft: AllUrlsBean(
          results: list,
          version: state.draft?.version,
          updatedAt: state.draft?.updatedAt),
      errorMessage: null,
    );
  }

  void reorderAt(int oldIndex, int newIndex) {
    final list = List<Results>.of(state.draft?.results ?? <Results>[]);
    if (oldIndex < 0 || oldIndex >= list.length) return;
    if (newIndex < 0 || newIndex >= list.length) return;
    final item = list.removeAt(oldIndex);
    list.insert(newIndex, item);
    state = state.copyWith(
      draft: AllUrlsBean(
        results: list,
        version: state.draft?.version,
        updatedAt: state.draft?.updatedAt,
      ),
      errorMessage: null,
    );
  }

  Future<void> saveToLocal() async {
    final draft = state.draft;
    if (draft == null) return;
    final updated = await _repo.save(draft);
    state = state.copyWith(
      data: AsyncData(updated),
      draft: AllUrlsBean(
        version: updated.version,
        updatedAt: updated.updatedAt,
        results: List.of(updated.results ?? <Results>[]),
      ),
      errorMessage: null,
    );
  }

  String buildExportJson() {
    final base = state.draft ?? state.data.value ?? AllUrlsBean(results: []);
    final nextVersion = (base.version ?? 0) + 1;
    final nowIso = DateTime.now().toUtc().toIso8601String();
    final exportBean = AllUrlsBean(
      version: nextVersion,
      updatedAt: nowIso,
      results: base.results == null ? null : List.of(base.results!),
    );
    const encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(exportBean.toJson());
  }

  bool get hasDirtyDraft =>
      LocalStorage.getItem(SomeKeys.DRAFT_DIRTY) == 'true';
}
