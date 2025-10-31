import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hao12345/bean/all_urls_bean.dart';
import 'package:hao12345/utils/local_storage.dart';
import 'package:hao12345/utils/some_keys.dart';

class NavigationRepository {
  NavigationRepository({Dio? dio});

  static const String _assetDefaultPath = 'assets/data/default_nav.json';

  Future<AllUrlsBean> fetch() async {
    final cache = LocalStorage.getItem(SomeKeys.NAV_CACHE);
    if (cache != null) {
      try {
        return AllUrlsBean.fromJson(jsonDecode(cache));
      } catch (_) {}
    }

    // 仅使用默认完整数据
    final assetStr = await rootBundle.loadString(_assetDefaultPath);
    return AllUrlsBean.fromJson(jsonDecode(assetStr));
  }

  Future<AllUrlsBean> save(AllUrlsBean bean) async {
    final nextVersion = (bean.version ?? 0) + 1;
    final nowIso = DateTime.now().toUtc().toIso8601String();
    final updated = AllUrlsBean(
      version: nextVersion,
      updatedAt: nowIso,
      results: bean.results == null ? null : List.of(bean.results!),
    );
    final content = jsonEncode(updated.toJson());
    LocalStorage.setItem(SomeKeys.NAV_CACHE, content);
    LocalStorage.setItem(SomeKeys.DRAFT_DIRTY, 'true');
    _updateLastSyncMeta(localEdited: nowIso);
    return updated;
  }

  String exportCurrentJson() {
    final cache = LocalStorage.getItem(SomeKeys.NAV_CACHE);
    if (cache != null && cache.isNotEmpty) return cache;
    return jsonEncode({'results': []});
  }

  void _updateLastSyncMeta({String? remoteFetched, String? localEdited}) {
    final metaStr = LocalStorage.getItem(SomeKeys.LAST_SYNC_META);
    Map<String, dynamic> meta = {};
    if (metaStr != null) {
      try {
        meta = jsonDecode(metaStr);
      } catch (_) {}
    }
    if (remoteFetched != null) meta['remote_last_fetched_at'] = remoteFetched;
    if (localEdited != null) meta['local_last_edited_at'] = localEdited;
    LocalStorage.setItem(SomeKeys.LAST_SYNC_META, jsonEncode(meta));
  }
}
